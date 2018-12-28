//
//  IDMoya+OAuthHandlerDelegate.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/27/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import Alamofire

public protocol IDMoyaOAuthHandlerDelegate {
	
	var idMoyaOAuthHandler_LogPrefixString					: String			{ get }
	
	// MARK: OAuthHandler Related
	
	var idMoyaOAuthHandler_ClientID							: String				{ get }
	var idMoyaOAuthHandler_BaseURLString					: String				{ get }
	func idMoyaOAuthHanlder_RefreshTokenEndpoint			(basedOn oauthObject: IDMoya.OAuthObject)						-> IDMoyaEndpointObject
	func idMoyaOAuthHandler_AdaptURLRequest					(urlRequest: URLRequest, with oauthObject: IDMoya.OAuthObject)	-> URLRequest
	func idMoyaOAuthHandler_DidSuccessfullyRefreshed		(withNewOAuthObject oauthObject: IDMoya.OAuthObject)
	func idMoyaOAuthHandler_DidFailedToRefresh				(response: DataResponse<Any>?)
	
	// MARK: OAuthObject Related
	var idMoyaOAuthHandler_UserDefaultsForStoringData		: UserDefaults										{ get }
	var idMoyaOAuthHandler_UserDefaultsKeysForStoringData	: IDMoya.OAuthHandler.OAuthObjectUserDefaultsKeys	{ get }
	var idMoyaOAuthHandler_StoredOAuthObject				: IDMoya.OAuthObject?								{ get }
	func idMoyaOAuthHandler_StoreNewOAuthObject				(_ oauthObject: IDMoya.OAuthObject)
	func idMoyaOAuthHandler_RemoveCurrentOAuthObject		()
	
	
}


public extension IDMoyaOAuthHandlerDelegate {
	
	public var idMoyaOAuthHandler_LogPrefixString					: String {
		return "IDMoya.OAuthHandler - "
	}
	
	public func idMoyaOAuthHanlder_RefreshTokenEndpoint				(basedOn oauthObject: IDMoya.OAuthObject) -> IDMoyaEndpointObject {
		return IDMoyaEndpointObject(
			baseURLString	: self.idMoyaOAuthHandler_BaseURLString,
			path			: "api/oauth2/token",
			method			: .post,
			encoding		: JSONEncoding.default,
			parameters		: [
				"access_token"	: oauthObject.accessToken,
				"refresh_token"	: oauthObject.refreshToken,
				"client_id"		: self.idMoyaOAuthHandler_ClientID,
				"grant_type"	: "refresh_token",
			],
			headers			: nil,
			useOAuth		: false
		)
	}
	
	public func idMoyaOAuthHandler_AdaptURLRequest					(urlRequest: URLRequest, with oauthObject: IDMoya.OAuthObject)	-> URLRequest {
		if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(self.idMoyaOAuthHandler_BaseURLString) {
			var urlRequest = urlRequest
			urlRequest.setValue("Bearer " + oauthObject.accessToken, forHTTPHeaderField: "Authorization")
			return urlRequest
		}
		return urlRequest
	}
	
	public func idMoyaOAuthHandler_DidSuccessfullyRefreshed			(withNewOAuthObject oauthObject: IDMoya.OAuthObject) {
		
	}
	
	public func idMoyaOAuthHandler_DidFailedToRefresh				(response: DataResponse<Any>?) {
		
	}
	
	public var idMoyaOAuthHandler_UserDefaultsForStoringData		: UserDefaults {
		return .standard
	}
	
	public var idMoyaOAuthHandler_UserDefaultsKeysForStoringData	: IDMoya.OAuthHandler.OAuthObjectUserDefaultsKeys {
		return (
			"IDAM.UDK.AO.AT",
			"IDAM.UDK.AO.RT",
			"IDAM.UDK.AO.EI",
			"IDAM.UDK.AO.CA"
		)
	}
	
	public var idMoyaOAuthHandler_StoredOAuthObject					: IDMoya.OAuthObject? {
		let userDefaults = self.idMoyaOAuthHandler_UserDefaultsForStoringData
		let userDefaultsKeys = self.idMoyaOAuthHandler_UserDefaultsKeysForStoringData
		guard
			let _accessToken		= userDefaults.object(forKey: userDefaultsKeys.accessToken) as? String,
			let _refreshToken		= userDefaults.object(forKey: userDefaultsKeys.refreshToken) as? String,
			let _createdAt_Double	= userDefaults.object(forKey: userDefaultsKeys.createdAt) as? Double,
			let _expiresIn			= userDefaults.object(forKey: userDefaultsKeys.expiresIn) as? Int
			else { return nil }
		
		return IDMoya.OAuthObject(
			accessToken		: _accessToken,
			refreshToken	: _refreshToken,
			expiresIn		: _expiresIn,
			createdAt		: Date(timeIntervalSince1970: _createdAt_Double)
		)
	}
	
	public func idMoyaOAuthHandler_StoreNewOAuthObject				(_ oauthObject: IDMoya.OAuthObject) {
		let userDefaults = self.idMoyaOAuthHandler_UserDefaultsForStoringData
		let userDefaultsKeys = self.idMoyaOAuthHandler_UserDefaultsKeysForStoringData
		userDefaults.set(oauthObject.accessToken						, forKey: userDefaultsKeys.accessToken)
		userDefaults.set(oauthObject.refreshToken						, forKey: userDefaultsKeys.refreshToken)
		userDefaults.set(oauthObject.expiresIn							, forKey: userDefaultsKeys.expiresIn)
		userDefaults.set(oauthObject.createdAt.timeIntervalSince1970	, forKey: userDefaultsKeys.createdAt)
		userDefaults.synchronize()
	}
	
	public func idMoyaOAuthHandler_RemoveCurrentOAuthObject			() {
		let userDefaults = self.idMoyaOAuthHandler_UserDefaultsForStoringData
		let userDefaultsKeys = self.idMoyaOAuthHandler_UserDefaultsKeysForStoringData
		userDefaults.set(nil, forKey: userDefaultsKeys.accessToken)
		userDefaults.set(nil, forKey: userDefaultsKeys.refreshToken)
		userDefaults.set(nil, forKey: userDefaultsKeys.expiresIn)
		userDefaults.set(nil, forKey: userDefaultsKeys.createdAt)
		userDefaults.synchronize()
	}
}


