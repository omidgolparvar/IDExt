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
	
	// MARK: OAuthHandler Related
	
	func idMoyaOAuthHanlder_RefreshTokenEndpoint			(_ oauthHandler: IDMoya.OAuthHandler)							-> IDMoyaEndpointObject
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
	
	public func idMoyaOAuthHanlder_RefreshTokenEndpoint				(_ oauthHandler: IDMoya.OAuthHandler) -> IDMoyaEndpointObject {
		return IDMoyaEndpointObject(
			baseURLString	: oauthHandler.baseURLString,
			path			: "api/oauth2/token",
			method			: .post,
			encoding		: IDMoya.JSONEncoding.default,
			parameters		: [
				"access_token"	: oauthHandler.oauthObject.accessToken,
				"refresh_token"	: oauthHandler.oauthObject.refreshToken,
				"client_id"		: oauthHandler.clientID,
				"grant_type"	: "refresh_token",
				"uuid"			: IDApplication.GetUUID(),
				"pid"			: IDApplication.OneSignalPlayerIDGetter() ?? "",
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
		response.id_CheckAndUse { >>>$0.result }
	}
	
	
	
	public var idMoyaOAuthHandler_StoredOAuthObject					: IDMoya.OAuthObject? {
		let userDefaults = UserDefaults.standard
		let userDefaultsKeys = (
			accessToken		: "IDAM.UDK.AO.AT",
			refreshToken	: "IDAM.UDK.AO.RT",
			expiresIn		: "IDAM.UDK.AO.EI",
			createdAt		: "IDAM.UDK.AO.CA"
		)
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
		let userDefaults = UserDefaults.standard
		let userDefaultsKeys = (
			accessToken		: "IDAM.UDK.AO.AT",
			refreshToken	: "IDAM.UDK.AO.RT",
			expiresIn		: "IDAM.UDK.AO.EI",
			createdAt		: "IDAM.UDK.AO.CA"
		)
		userDefaults.set(oauthObject.accessToken						, forKey: userDefaultsKeys.accessToken)
		userDefaults.set(oauthObject.refreshToken						, forKey: userDefaultsKeys.refreshToken)
		userDefaults.set(oauthObject.expiresIn							, forKey: userDefaultsKeys.expiresIn)
		userDefaults.set(oauthObject.createdAt.timeIntervalSince1970	, forKey: userDefaultsKeys.createdAt)
		userDefaults.synchronize()
	}
	
	public func idMoyaOAuthHandler_RemoveCurrentOAuthObject			() {
		let userDefaults = UserDefaults.standard
		let userDefaultsKeys = (
			accessToken		: "IDAM.UDK.AO.AT",
			refreshToken	: "IDAM.UDK.AO.RT",
			expiresIn		: "IDAM.UDK.AO.EI",
			createdAt		: "IDAM.UDK.AO.CA"
		)
		userDefaults.set(nil, forKey: userDefaultsKeys.accessToken)
		userDefaults.set(nil, forKey: userDefaultsKeys.refreshToken)
		userDefaults.set(nil, forKey: userDefaultsKeys.expiresIn)
		userDefaults.set(nil, forKey: userDefaultsKeys.createdAt)
		userDefaults.synchronize()
	}
	
}


