//

import Foundation
import Alamofire
import SwiftyJSON

public extension IDMoya {
	
	public final class OAuthObject: CustomStringConvertible {
		
		public var accessToken	: String
		public var expiresIn	: Int
		public var refreshToken	: String
		public var createdAt	: Date
		
		public var description	: String {
			return """
			AccessToken  : \(accessToken)
			RefreshToken : \(refreshToken)
			"""
		}
		
		public convenience init?(fromJSONObject json: IDMoya.JSON) {
			guard
				let _accessToken	= json["access_token"].string,
				let _expiresIn		= json["expires_in"].int,
				let _refreshToken	= json["refresh_token"].string
				else { return nil }
			self.init(accessToken: _accessToken, refreshToken: _refreshToken, expiresIn: _expiresIn, createdAt: Date())
		}
		
		public convenience init?(fromDictionary dictionary: [String: Any]) {
			guard
				let _accessToken	= dictionary["access_token"] as? String,
				let _expiresIn		= dictionary["expires_in"] as? Int,
				let _refreshToken	= dictionary["refresh_token"] as? String
				else { return nil }
			self.init(accessToken: _accessToken, refreshToken: _refreshToken, expiresIn: _expiresIn, createdAt: Date())
		}
		
		public convenience init?(fromJSONData data: Any?) {
			guard let data = data else { return nil }
			self.init(fromJSONObject: IDMoya.JSON(data))
		}
		
		public init(accessToken: String, refreshToken: String, expiresIn: Int, createdAt: Date) {
			self.accessToken	= accessToken
			self.refreshToken	= refreshToken
			self.expiresIn		= expiresIn
			self.createdAt		= createdAt
		}
		
	}
	
}


