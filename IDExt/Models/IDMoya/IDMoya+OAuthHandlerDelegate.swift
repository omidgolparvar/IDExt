//

import Foundation
import Alamofire

fileprivate let UserDefaultsKeys = (
	accessToken		: "IDAM.UDK.AO.AT",
	refreshToken	: "IDAM.UDK.AO.RT",
	expiresIn		: "IDAM.UDK.AO.EI",
	createdAt		: "IDAM.UDK.AO.CA"
)

public protocol IDMoyaOAuthHandlerDelegate: NSObjectProtocol {
	
	// MARK: OAuthHandler Related
	
	func idMoyaOAuthHanlder_RefreshTokenEndpoint			(_ oauthHandler: IDMoya.OAuthHandler)							-> IDMoyaEndpoint
	func idMoyaOAuthHandler_AdaptURLRequest					(_ oauthHandler: IDMoya.OAuthHandler, urlRequest: URLRequest)	-> URLRequest
	func idMoyaOAuthHandler_DidSuccessfullyRefreshed		(_ oauthHandler: IDMoya.OAuthHandler, withNewOAuthObject oauthObject: IDMoya.OAuthObject)
	func idMoyaOAuthHandler_DidFailedToRefresh				(_ oauthHandler: IDMoya.OAuthHandler, withResponse response: IDMoya.DataResponse<Any>?)
	func idMoyaOAuthHandler_ShouldLogoutCurrentUser			()
	
	
	// MARK: OAuthObject Related
	
	var idMoyaOAuthHandler_StoredOAuthObject				: IDMoya.OAuthObject?				{ get }
	func idMoyaOAuthHandler_StoreNewOAuthObject				(_ oauthObject: IDMoya.OAuthObject)
	func idMoyaOAuthHandler_RemoveCurrentOAuthObject		()
	
	
}


public extension IDMoyaOAuthHandlerDelegate {
	
	public func idMoyaOAuthHanlder_RefreshTokenEndpoint				(_ oauthHandler: IDMoya.OAuthHandler) -> IDMoyaEndpoint {
		return IDMoyaEndpoint(
			baseURLString	: oauthHandler.baseURLString,
			path			: "api/oauth2/token",
			method			: .post,
			encoding		: IDMoya.JSONEncoding.default,
			parameters		: [
				"access_token"	: oauthHandler.oauthObject.accessToken,
				"refresh_token"	: oauthHandler.oauthObject.refreshToken,
				"client_id"		: oauthHandler.clientID,
				"grant_type"	: "refresh_token",
				"uuid"			: UIApplication.SharedDelegate?.idApplication_UUID ?? "",
				"pid"			: UIApplication.SharedDelegate?.idApplication_OneSignalPlayerID ?? "",
				"os"			: "iOS",
				"os_version"	: UIDevice.current.systemVersion,
				"phone_model"	: "\(UIDevice.current.dc.deviceModel)",
				"app_version"	: UIApplication.ID_FullVersionAndBuildNumber,
			],
			headers			: nil,
			useOAuth		: false
		)
	}
	
	public func idMoyaOAuthHandler_AdaptURLRequest					(_ oauthHandler: IDMoya.OAuthHandler, urlRequest: URLRequest) -> URLRequest {
		if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(oauthHandler.baseURLString) {
			var urlRequest = urlRequest
			urlRequest.setValue("Bearer " + oauthHandler.oauthObject.accessToken, forHTTPHeaderField: "Authorization")
			return urlRequest
		}
		return urlRequest
	}
	
	public func idMoyaOAuthHandler_DidSuccessfullyRefreshed			(_ oauthHandler: IDMoya.OAuthHandler, withNewOAuthObject oauthObject: IDMoya.OAuthObject) {
		>>>"\(#function)"
		>>>oauthObject
	}
	
	public func idMoyaOAuthHandler_DidFailedToRefresh				(_ oauthHandler: IDMoya.OAuthHandler, withResponse response: IDMoya.DataResponse<Any>?) {
		>>>"\(#function)"
		
		response.id_IfIsNotNil { >>>$0.result }
	}
	
	
	
	public var idMoyaOAuthHandler_StoredOAuthObject					: IDMoya.OAuthObject? {
		let userDefaults = UserDefaults.standard
		
		guard
			let _accessToken		= userDefaults.object(forKey: UserDefaultsKeys.accessToken) as? String,
			let _refreshToken		= userDefaults.object(forKey: UserDefaultsKeys.refreshToken) as? String,
			let _createdAt_Double	= userDefaults.object(forKey: UserDefaultsKeys.createdAt) as? Double,
			let _expiresIn			= userDefaults.object(forKey: UserDefaultsKeys.expiresIn) as? Int
			else { return nil }
		
		return IDMoya.OAuthObject(
			accessToken		: _accessToken,
			refreshToken	: _refreshToken,
			expiresIn		: _expiresIn,
			createdAt		: Date(timeIntervalSince1970: _createdAt_Double)
		)
	}
	
	public func idMoyaOAuthHandler_StoreNewOAuthObject				(_ oauthObject: IDMoya.OAuthObject) {
		let userDefaults = UserDefaults.standard
		userDefaults.set(oauthObject.accessToken						, forKey: UserDefaultsKeys.accessToken)
		userDefaults.set(oauthObject.refreshToken						, forKey: UserDefaultsKeys.refreshToken)
		userDefaults.set(oauthObject.expiresIn							, forKey: UserDefaultsKeys.expiresIn)
		userDefaults.set(oauthObject.createdAt.timeIntervalSince1970	, forKey: UserDefaultsKeys.createdAt)
	}
	
	public func idMoyaOAuthHandler_RemoveCurrentOAuthObject			() {
		let userDefaults = UserDefaults.standard
		userDefaults.removeObject(forKey: UserDefaultsKeys.accessToken)
		userDefaults.removeObject(forKey: UserDefaultsKeys.refreshToken)
		userDefaults.removeObject(forKey: UserDefaultsKeys.expiresIn)
		userDefaults.removeObject(forKey: UserDefaultsKeys.createdAt)
	}
	
}


