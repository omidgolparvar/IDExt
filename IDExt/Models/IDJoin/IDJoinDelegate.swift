//
//  IDLoginDelegate.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/19/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDJoinDelegate: NSObjectProtocol {
	
	func idJoin_BaseURL						()					-> URL
	func idJoin_SubmitMobileEndpoint		(_ idJoin: IDJoin)	-> IDMoyaEndpointObject
	func idJoin_SubmitOneTimeCodeEndpoint	(_ idJoin: IDJoin)	-> IDMoyaEndpointObject
	
	func idJoin_DidSubmitMobile				(_ idJoin: IDJoin, withResult result: IDMoya.ResultStatus, andData data: AnyObject?)
	func idJoin_DidSubmitMobile				(_ idJoin: IDJoin, withError error: Error?, andData data: AnyObject?)
	func idJoin_DidSubmitOneTimeCode		(_ idJoin: IDJoin, withResult result: IDMoya.ResultStatus, andData data: AnyObject?)
	func idJoin_DidSubmitOneTimeCode		(_ idJoin: IDJoin, withError error: Error?, andData data: AnyObject?)
	
}

extension IDJoinDelegate {
	
	func idJoin_SubmitMobileEndpoint		(_ idJoin: IDJoin)	-> IDMoyaEndpointObject {
		return IDMoyaEndpointObject(
			baseURL		: self.idJoin_BaseURL(),
			path		: "user/mobile-request/0",
			method		: .post,
			encoding	: .httpBody,
			parameters	: [
				"mobile"	: idJoin.mobileNumber,
				"uuid"		: IDApplication.GetUUID()
			],
			headers		: nil,
			useOAuth	: false
		)
	}
	
	func idJoin_SubmitOneTimeCodeEndpoint	(_ idJoin: IDJoin)	-> IDMoyaEndpointObject {
		return IDMoyaEndpointObject(
			baseURL		: self.idJoin_BaseURL(),
			path		: "api/oauth2/token",
			method		: .post,
			encoding	: .httpBody,
			parameters	: [
				"grant_type"	: "password",
				"username"		: idJoin.mobileNumber,
				"password"		: idJoin.oneTimeCode,
				"client_id"		: "public-ios",
				"uuid"			: IDApplication.GetUUID(),
				"pid"			: IDApplication.OneSignalPlayerIDGetter() ?? "",
				"os"			: "iOS",
				"os_version"	: UIDevice.current.systemVersion,
				"phone_model"	: "\(UIDevice.current.dc.deviceModel)",
				"app_version"	: UIApplication.ID_FullVersionAndBuildNumber,
			],
			headers		: nil,
			useOAuth	: false
		)
	}
	
	func idJoin_DidSubmitMobile				(_ idJoin: IDJoin, withResult result: IDMoya.ResultStatus, andData data: AnyObject?) {
		guard let statusObject = IDMoya.StatusObject(from: data) else {
			self.idJoin_DidSubmitMobile(idJoin, withError: IDError.withData(data), andData: data)
			return
		}
		
		switch statusObject {
		case .success:
			self.idJoin_DidSubmitMobile(idJoin, withError: nil, andData: data)
		case .failedWithSingleMessage(_),
			 .failedMultipleFieldMessage(_):
			self.idJoin_DidSubmitMobile(idJoin, withError: IDError.errorWithCustomMessage(statusObject.errorMessage), andData: data)
		}
	}
	
	func idJoin_DidSubmitOneTimeCode		(_ idJoin: IDJoin, withResult result: IDMoya.ResultStatus, andData data: AnyObject?) {
		switch result {
		case .success:
			if let oauthObject = IDMoya.OAuthObject(fromJSONData: data) {
				IDUser.current.setup(oauthObject: oauthObject)
				self.idJoin_DidSubmitOneTimeCode(idJoin, withError: nil, andData: data)
			} else {
				self.idJoin_DidSubmitOneTimeCode(idJoin, withError: IDError.withData(data), andData: data)
			}
		case .noConnection:
			self.idJoin_DidSubmitOneTimeCode(idJoin, withError: IDError.noConnection, andData: nil)
		default:
			self.idJoin_DidSubmitOneTimeCode(idJoin, withError: IDError.withData(data), andData: data)
		}
	}
	
}
