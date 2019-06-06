//

import Foundation

public final class IDMoyaEndpoint {
	
	internal var identifier		: String
	internal var baseURLString	: String
	internal var path			: String
	internal var method			: IDMoya.Method
	internal var encoding		: IDMoya.Encoding
	internal var parameters		: IDMoya.Parameters?
	internal var headers		: IDMoya.Header?
	internal var useOAuth		: Bool
	
	public var fullPath			: String {
		return baseURLString + path
	}
	
	public init(identifier		: String? = nil,
				baseURLString	: String,
				path			: String,
				method			: IDMoya.Method,
				encoding		: IDMoya.Encoding,
				parameters		: IDMoya.Parameters?,
				headers			: IDMoya.Header?,
				useOAuth		: Bool) {
		
		self.identifier		= identifier ?? UUID().uuidString
		self.baseURLString	= baseURLString
		self.path			= path
		self.method			= method
		self.encoding		= encoding
		self.parameters		= parameters
		self.headers		= headers
		self.useOAuth		= useOAuth
	}
	
	public func addParameters(_ params: [String: Any]) {
		if self.parameters == nil {
			self.parameters = [:]
		}
		for (key, value) in params {
			self.parameters![key] = value
		}
	}
	
	public func setParameters(_ params: [String: Any]) {
		self.parameters = params
	}
	
	
	
}
