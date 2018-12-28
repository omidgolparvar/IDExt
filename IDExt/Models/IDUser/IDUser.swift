//
//  IDUser.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/19/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

open class IDUser {
	
	public static var current = IDUser(withInitType: .raw)!
	
	open class func IsExist() -> Bool {
		fatalError("IDUser - \(#function): has not been implemented.")
	}
	
	
	public var oauthObject				: IDMoya.OAuthObject?	= nil
	public var isChecked				: Bool					= false
	
	public var isLoggedIn				: Bool { return oauthObject != nil }
	open var accountingBaseURLString	: String? { fatalError("IDUser.BaseURL not implemented.") }
	
	open var checkAccountEndpoint	: IDMoyaEndpointObject {
		return IDMoyaEndpointObject(
			baseURLString	: accountingBaseURLString!,
			path			: "user/account",
			method			: .get,
			encoding		: URLEncoding.default,
			parameters		: nil,
			headers			: nil,
			useOAuth		: true
		)
	}
	
	open var logoutEndpoint			: IDMoyaEndpointObject? {
		return IDMoyaEndpointObject(
			baseURLString	: accountingBaseURLString!,
			path			: "user/logout",
			method			: .post,
			encoding		: URLEncoding.default,
			parameters		: nil,
			headers			: nil,
			useOAuth		: true
		)
	}
	
	public init() {
		
	}
	
	public convenience init?(withInitType type: IDUser.InitType) {
		switch type {
		case .raw						: self.init()
		case .data(let data)			: self.init(fromData: data)
		case .userDefaults				: self.init(fromUserDefaults: true)
		case .authObject(let object)	: self.init(fromOAthObject: object)
		}
	}
	
	public init?(fromData data: AnyObject?) {
		fatalError("IDUser - \(#function): has been not implemented.")
	}
	
	public init?(fromUserDefaults flag: Bool) {
		guard flag else { return nil }
		guard let oauthObject = IDMoya.OAuthHandler.SharedDelegate?.idMoyaOAuthHandler_StoredOAuthObject else { return nil }
		self.oauthObject = oauthObject
		IDMoya.SetupOAuthSessionManager(oauthObject: oauthObject)
	}
	
	public init(fromOAthObject object: IDMoya.OAuthObject) {
		self.oauthObject = object
		IDMoya.OAuthHandler.SharedDelegate!.idMoyaOAuthHandler_StoreNewOAuthObject(object)
		IDMoya.SetupOAuthSessionManager(oauthObject: object)
	}
	
	open func setup(oauthObject object: IDMoya.OAuthObject) {
		self.oauthObject = object
		IDMoya.OAuthHandler.SharedDelegate!.idMoyaOAuthHandler_StoreNewOAuthObject(object)
		IDMoya.SetupOAuthSessionManager(oauthObject: object)
	}
	
	open func logout(callback: @escaping (Error?, AnyObject?) -> Void = { _,_  in }) {
		if let logoutEndpoint = logoutEndpoint {
			IDMoya.Perform(logoutEndpoint) { (result, data) in
				switch result {
				case .success:
					if let statusObject = IDMoya.StatusObject(from: data) {
						switch statusObject {
						case .success:
							IDUser.current.oauthObject	= nil
							IDUser.current.isChecked	= false
							IDMoya.OAuthHandler.SharedDelegate!.idMoyaOAuthHandler_RemoveCurrentOAuthObject()
							callback(nil, data)
						default:
							callback(IDError.withData(data), data)
						}
					} else {
						callback(IDError.withData(data), data)
					}
				case .noConnection:
					callback(IDError.noConnection, nil)
				default:
					callback(IDError.unknownError, nil)
				}
			}
		} else {
			oauthObject	= nil
			isChecked	= false
			IDMoya.OAuthHandler.SharedDelegate!.idMoyaOAuthHandler_RemoveCurrentOAuthObject()
		}
	}
	
	open func validateCheckAccountResponse(with data: AnyObject?) -> Bool {
		fatalError("IDUser - \(#function): has not been implemented.")
	}
	
	open func checkAccount(callback: @escaping (Error?, AnyObject?) -> Void) {
		IDMoya.Perform(checkAccountEndpoint) { [weak self] (result, data) in
			guard let _self = self else { return }
			switch result {
			case .success:
				if _self.validateCheckAccountResponse(with: data) {
					callback(nil, data)
				} else {
					callback(IDError.withData(data), data)
				}
			case .unauthorized:
				callback(IDError.unAuthorized, data)
			case .noConnection:
				callback(IDError.noConnection, data)
			default:
				callback(IDError.withData(data), data)
			}
			
		}
	}
	
}

