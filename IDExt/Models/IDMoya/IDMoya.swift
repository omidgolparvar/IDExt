//

import Foundation
import Alamofire
import SwiftyJSON
import SystemConfiguration

public final class IDMoya {
	
	public typealias DataRequest		= Alamofire.DataRequest
	public typealias DataResponse		= Alamofire.DataResponse
	public typealias UploadRequest		= Alamofire.UploadRequest
	public typealias Method				= Alamofire.HTTPMethod
	public typealias Encoding			= Alamofire.ParameterEncoding
	public typealias URLEncoding		= Alamofire.URLEncoding
	public typealias JSONEncoding		= Alamofire.JSONEncoding
	public typealias Progress			= Alamofire.Progress
	public typealias Parameters			= Alamofire.Parameters
	public typealias JSON				= SwiftyJSON.JSON
	public typealias UploadParameter	= (name: String, data: Data, fileName: String, mimeType: String)
	public typealias Header				= [String: String]
	public typealias Callback			= (_ result: ResultStatus, _ data: Any?) -> Void
	
	internal static var RequestsDictionary	: [ObjectIdentifier : DataRequest] = [:]
	internal static var OAuthSessionManager	: SessionManager?
	
	
	public static var ErrorMessagePrefix	: String	= "⚠️ IDMoya - Error:"
	public static var IsVerbose				: Bool		= false
	
	@discardableResult
	public static func Perform(_ endpoint: IDMoyaEndpoint, callback: @escaping Callback) -> DataRequest? {
		return Perform(endpoint, handler: .callback(callback))
	}
	
	@discardableResult
	public static func Perform(_ endpoint: IDMoyaEndpoint, delegate: IDMoyaResponsechiDelegate) -> DataRequest? {
		weak var weakDelegate = delegate
		return Perform(endpoint, handler: .delegate(weakDelegate))
	}
	
	internal static func Perform(_ endpoint: IDMoyaEndpoint, handler: ResponseHandler) -> DataRequest? {
		
		guard isConnectedToNetwork else {
			switch handler {
			case .callback(let callback):
				callback(.noConnection, nil)
			case .delegate(let delegate):
				guard let delegate = delegate else { return nil }
				delegate.idMoya_HasNoConnectionHandler ?
					delegate.idMoya_FailedBecauseOfNoConnection(endpoint: endpoint) :
					delegate.idMoya_Succeeded(endpoint: endpoint, withResultStatus: .noConnection, data: nil)
			}
			return nil
		}
		
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
		
		var request: DataRequest?
		if endpoint.useOAuth {
			request = OAuthSessionManager?
				.request(
					endpoint.baseURLString + endpoint.path,
					method		: endpoint.method,
					parameters	: endpoint.parameters,
					encoding	: endpoint.encoding,
					headers		: endpoint.headers
				)
				.validate(statusCode: ResultStatus.AllWithoutUnauthorized)
				.responseJSON { response in HandleResponse(request: request, response: response, endpoint: endpoint, handler: handler) }
		} else {
			request = Alamofire
				.request(
					endpoint.baseURLString + endpoint.path,
					method		: endpoint.method,
					parameters	: endpoint.parameters,
					encoding	: endpoint.encoding,
					headers		: endpoint.headers
				)
				.responseJSON { response in HandleResponse(request: request, response: response, endpoint: endpoint, handler: handler) }
		}
		
		if let request = request {
			let identifier = ObjectIdentifier(request)
			RequestsDictionary[identifier] = request
		}
		
		return request
	}
	
	public static var isConnectedToNetwork: Bool {
		var zeroAddress = sockaddr_in()
		zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
		zeroAddress.sin_family = sa_family_t(AF_INET)
		let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
			$0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
				SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
			}
		}
		var flags = SCNetworkReachabilityFlags()
		if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
			return false
		}
		let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
		let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
		return (isReachable && !needsConnection)
	}
	
	public static var isConnectedToVPN: Bool {
		guard
			let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? Dictionary<String, Any>,
			let scopes = settings["__SCOPED__"] as? [String:Any]
			else { return false }
		for (key, _) in scopes {
			if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") || key.contains("ipsec0") {
				return true
			}
		}
		return false
	}
	
	public static func SetupOAuthSessionManager(cliendID: String, baseURLString: String, oauthObject: OAuthObject) {
		let sessionManager = SessionManager()
		let oauthHandler = OAuthHandler(clientID: cliendID, baseURLString: baseURLString, oauthObject: oauthObject)
		sessionManager.adapter = oauthHandler
		sessionManager.retrier = oauthHandler
		OAuthSessionManager = sessionManager
	}
	
	public static func PrintData(_ data: Any?) {
		print("IDMoya - " + #function + " : ")
		guard let data = data else { print("--- NO Data.") ; return }
		print(IDMoya.JSON(data))
	}
	
	public static func CancelRequest(_ request: DataRequest?) {
		guard let request = request else { return }
		request.cancel()
		RequestsDictionary.removeValue(forKey: ObjectIdentifier(request))
		UIApplication.shared.isNetworkActivityIndicatorVisible = !RequestsDictionary.isEmpty
	}
	
	public static func CancelAllRequest() {
		OAuthSessionManager?.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
			sessionDataTask.forEach { $0.cancel() }
			uploadData.forEach { $0.cancel() }
			downloadData.forEach { $0.cancel() }
		}
		Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
			sessionDataTask.forEach { $0.cancel() }
			uploadData.forEach { $0.cancel() }
			downloadData.forEach { $0.cancel() }
		}
		RequestsDictionary.removeAll()
		UIApplication.shared.isNetworkActivityIndicatorVisible = false
	}
	
	public static func SetupDefaultSessionManager(_ closure: (SessionManager?) -> Void) {
		closure(Alamofire.SessionManager.default)
	}
	
	public static func SetupOAuthSessionManager(_ closure: (SessionManager?) -> Void) {
		closure(OAuthSessionManager)
	}
	
}

public extension IDMoya {
	//TODO using IDError instead of raw string
	
	public enum ResponseHandler {
		case callback(Callback)
		case delegate(IDMoyaResponsechiDelegate?)
		
	}
	
	public enum StatusObject {
		
		case success
		case failedMultipleFieldMessage([(field: String, message: String)])
		case failedWithSingleMessage(String)
		
		public init?(from data: Any?) {
			guard let data = data else { return nil }
			let jsonObject = IDMoya.JSON(data)
			if let status = jsonObject["status"].bool, status == true { self = .success }
			else if let status = jsonObject["status"].string, status == "1" { self = .success }
			else if let status = jsonObject["status"].int, status == 1 { self = .success }
			else {
				if let array = jsonObject.array {
					
					let arrayOfFieldMessages: [(String, String)] = array.compactMap { (item) in
						guard
							let field = item["field"].string,
							let message = item["message"].string?.trimmingCharacters(in: .whitespacesAndNewlines)
							else { return nil }
						return (field, message)
					}
					if arrayOfFieldMessages.isEmpty {
						self = .failedWithSingleMessage("خطای نامشخصی رخ داده است.")
					} else {
						self = .failedMultipleFieldMessage(arrayOfFieldMessages)
					}
					
				} else if
					let field = jsonObject["field"].string,
					let message = jsonObject["message"].string?.trimmingCharacters(in: .whitespacesAndNewlines) {
					
					self = .failedMultipleFieldMessage([(field, message)])
					
				} else if let message = jsonObject["message"].string?.trimmingCharacters(in: .whitespacesAndNewlines) {
					
					self = .failedWithSingleMessage(message)
					
				} else {
					self = .failedWithSingleMessage("خطای نامشخصی رخ داده است.")
				}
			}
		}
		
		public var errorMessage: String {
			switch self {
			case .success: return ""
			case .failedWithSingleMessage(let message):
				return message
			case .failedMultipleFieldMessage(let array):
				return array.map({ (item) -> String in
					let field = item.field
					let message = item.message
					if field.isEmpty {
						return "⚠️ " + message
					} else {
						return "⚠️ " + field + ": " + message
					}
				}).joined(separator: "\n")
			}
		}
		
	}
	
	public enum ResultStatus: Int {
		
		public static let AllWithoutUnauthorized = Array(200...400) + Array(402..<600)
		
		case unknown				= -100
		case notRequested			= -200
		case noConnection			= -300
		case requestCanceled		= -1001
		
		case success				= 200
		
		case badRequest				= 400
		case unauthorized			= 401
		case forbidden				= 403
		case notFound				= 404
		case methodNotAllowed		= 405
		case unprocessableEntity	= 422
		
		case internalServerError	= 500
		case serviceUnavailable		= 503
		
	}
	
}
