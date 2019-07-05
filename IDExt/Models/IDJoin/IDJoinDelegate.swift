//
//  IDLoginDelegate.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/19/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import Alamofire

public protocol IDJoinDelegate: NSObjectProtocol {
	
	var idJoin_BaseURLString				: String { get }
	var idJoin_SubmitMobilePath				: String { get }
	var idJoin_SubmitOneTimeCodePath		: String { get }
	
	func idJoin_SubmitMobileEndpoint		(_ idJoin: IDJoin)	-> IDMoyaEndpoint
	func idJoin_SubmitOneTimeCodeEndpoint	(_ idJoin: IDJoin)	-> IDMoyaEndpoint
	
	func idJoin_DidSubmitMobile				(_ idJoin: IDJoin, withResult result: IDMoya.ResultStatus, andData data: Any?)
	func idJoin_DidSubmitMobile				(_ idJoin: IDJoin, withError error: Error?, andData data: Any?)
	func idJoin_DidSubmitOneTimeCode		(_ idJoin: IDJoin, withResult result: IDMoya.ResultStatus, andData data: Any?)
	func idJoin_DidSubmitOneTimeCode		(_ idJoin: IDJoin, withError error: Error?, andData data: Any?)
	
}

public extension IDJoinDelegate {
	
	var idJoin_SubmitMobilePath				: String { return "api/v1/user/mobile-token/0" }
	var idJoin_SubmitOneTimeCodePath		: String { return "api/oauth2/token" }
	
	func idJoin_SubmitMobileEndpoint		(_ idJoin: IDJoin)	-> IDMoyaEndpoint {
		return IDMoyaEndpoint(
			baseURLString	: self.idJoin_BaseURLString,
			path			: self.idJoin_SubmitMobilePath,
			method			: .post,
			encoding		: URLEncoding.httpBody,
			parameters		: [
				"mobile"	: idJoin.mobileNumber,
				"uuid"		: UIApplication.SharedDelegate?.idApplication_UUID ?? ""
			],
			headers			: nil,
			useOAuth		: false
		)
	}
	
	func idJoin_SubmitOneTimeCodeEndpoint	(_ idJoin: IDJoin)	-> IDMoyaEndpoint {
		return IDMoyaEndpoint(
			baseURLString	: self.idJoin_BaseURLString,
			path			: self.idJoin_SubmitOneTimeCodePath,
			method			: .post,
			encoding		: URLEncoding.httpBody,
			parameters		: [
				"grant_type"	: "password",
				"username"		: idJoin.mobileNumber,
				"password"		: idJoin.oneTimeCode,
				"client_id"		: "public-ios",
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
	
	func idJoin_DidSubmitMobile				(_ idJoin: IDJoin, withResult result: IDMoya.ResultStatus, andData data: Any?) {
		switch result {
		case .success:
			self.idJoin_DidSubmitMobile(idJoin, withError: nil, andData: data)
		case .noConnection:
			self.idJoin_DidSubmitMobile(idJoin, withError: IDError.noConnection, andData: data)
		default:
			self.idJoin_DidSubmitMobile(idJoin, withError: IDError.withData(data), andData: data)
		}
	}
	
	func idJoin_DidSubmitOneTimeCode		(_ idJoin: IDJoin, withResult result: IDMoya.ResultStatus, andData data: Any?) {
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
