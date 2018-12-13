//
//  IDMoya+OAuthHandler.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/26/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension IDMoya {
	
	public final class OAuthHandler: RequestAdapter, RequestRetrier {
		
		private static let LogPrefixString		= "IDMoya.OAuthHandler - "
		
		public static var LogoutClosure				: () -> Void			= { }
		public static var OAuthObjectClosure		: (OAuthObject) -> Void	= { _ in }
		public static var CustomParametersClosure	: () -> [String: Any]?	= { return nil }
		
		private typealias RefreshCompletion = (_ succeeded: Bool, _ result: OAuthObject?) -> Void
		
		private let sessionManager: SessionManager = {
			let configuration = URLSessionConfiguration.default
			configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
			return SessionManager(configuration: configuration)
		}()
		
		private let lock = NSLock()
		
		private var clientID				: String
		private var baseURLString			: String
		private var refreshTokenURLString	: String
		private var oauthObject				: OAuthObject
		private var isRefreshing			: Bool = false
		private var requestsToRetry			: [RequestRetryCompletion] = []
		
		public init(clientID: String, baseURLString: String, refreshTokenURLString: String?, oauthObject: OAuthObject) {
			self.clientID				= clientID
			self.baseURLString			= baseURLString
			self.refreshTokenURLString	= refreshTokenURLString ?? "\(baseURLString)api/oauth2/token"
			self.oauthObject			= oauthObject
		}
		
		public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
			if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(baseURLString) {
				var urlRequest = urlRequest
				urlRequest.setValue("Bearer " + oauthObject.accessToken, forHTTPHeaderField: "Authorization")
				return urlRequest
			}
			return urlRequest
		}
		
		public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
			IDMoya.IsVerbose.id_IfIsTrue {
				print(OAuthHandler.LogPrefixString + #function)
			}
			
			lock.lock() ; defer { lock.unlock() }
			
			if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
				requestsToRetry.append(completion)
				
				if !isRefreshing {
					refreshTokens { [weak self] succeeded, authObject in
						IDMoya.IsVerbose.id_IfIsTrue {
							print(OAuthHandler.LogPrefixString + #function + " - RefreshToken Callback")
						}
						guard let strongSelf = self else { return }
						
						strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
						
						if let authObject = authObject {
							IDMoya.IsVerbose.id_IfIsTrue {
								print(OAuthHandler.LogPrefixString + #function + " - New Token: \(authObject.accessToken)")
							}
							IDMoya.OAuthObject.StoreObjectToUserDefaults(authObject)
							IDMoya.OAuthHandler.OAuthObjectClosure(authObject)
							strongSelf.oauthObject = authObject
						} else {
							IDMoya.OAuthHandler.LogoutClosure()
							NotificationCenter.default.post(name: NotificationKeys.RefreshTokenFailed, object: nil)
						}
						
						strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
						strongSelf.requestsToRetry.removeAll()
						
						IDMoya.IsVerbose.id_IfIsTrue {
							print(OAuthHandler.LogPrefixString + #function + " - RefreshToken Callback Ends.")
						}
					}
				}
			} else {
				completion(false, 0.0)
			}
		}
		
		public func setURLStrings(baseURLString: String, refreshTokenURLString: String?) {
			self.baseURLString			= baseURLString
			self.refreshTokenURLString	= refreshTokenURLString ?? "\(baseURLString)api/oauth2/token"
		}
		
		private func refreshTokens(completion: @escaping RefreshCompletion) {
			guard !isRefreshing else { return }
			
			isRefreshing = true
			
			var parameters: [String: Any] = [
				"access_token"	: oauthObject.accessToken,
				"refresh_token"	: oauthObject.refreshToken,
				"client_id"		: clientID,
				"grant_type"	: "refresh_token",
				]
			
			if let customParameters = IDMoya.OAuthHandler.CustomParametersClosure() {
				for (key, value) in customParameters {
					parameters[key] = value
				}
			}
			
			sessionManager
				.request(refreshTokenURLString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
				.responseJSON { [weak self] response in
					guard let strongSelf = self else { return }
					
					if	let json = response.result.value as? [String: Any],
						let oauthObject = OAuthObject(fromDictionary: json) {
						completion(true, oauthObject)
					} else {
						IDMoya.IsVerbose.id_IfIsTrue {
							print(IDMoya.OAuthHandler.LogPrefixString + #function + " - Invalid Response.")
						}
						completion(false, nil)
					}
					strongSelf.isRefreshing = false
			}
		}
	}
	
}

extension IDMoya.OAuthHandler {
	
	public final class NotificationKeys {
		
		public static var RefreshTokenFailed: Notification.Name { return .init("IDAM.NN.RefreshTokenFailed") }
		
	}
	
}


