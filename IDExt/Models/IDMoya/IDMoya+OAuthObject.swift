//
//  IDMoya+OAuthObject.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/26/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension IDMoya {
	
	public final class OAuthObject {
		
		public static var UserDefaultsGetter	: () -> UserDefaults	= { return UserDefaults.standard }
		
		public var accessToken	: String
		public var expiresIn	: Int
		public var refreshToken	: String
		public var createdAt	: Date
		
		public convenience init?(fromJSONObject json: JSON) {
			guard
				let _accessToken = json["access_token"].string,
				let _expiresIn = json["expires_in"].int,
				let _refreshToken = json["refresh_token"].string
				else { return nil }
			self.init(accessToken: _accessToken, refreshToken: _refreshToken, expiresIn: _expiresIn, createdAt: Date())
		}
		
		public convenience init?(fromDictionary dictionary: [String: Any]) {
			guard
				let _accessToken = dictionary["access_token"] as? String,
				let _expiresIn = dictionary["expires_in"] as? Int,
				let _refreshToken = dictionary["refresh_token"] as? String
				else { return nil }
			self.init(accessToken: _accessToken, refreshToken: _refreshToken, expiresIn: _expiresIn, createdAt: Date())
		}
		
		public convenience init?(fromJSONData data: AnyObject?) {
			guard let data = data else { return nil }
			self.init(fromJSONObject: JSON(data))
		}
		
		public init(accessToken: String, refreshToken: String, expiresIn: Int, createdAt: Date) {
			self.accessToken = accessToken
			self.refreshToken = refreshToken
			self.expiresIn = expiresIn
			self.createdAt = createdAt
		}
		
		
		
		
		public static func StoredObjectFromUserDefaults() -> OAuthObject? {
			let userDefaults = UserDefaultsGetter()
			guard
				let _accessToken		= userDefaults.object(forKey: UserDefaultsKeys.AccessToken) as? String,
				let _refreshToken		= userDefaults.object(forKey: UserDefaultsKeys.RefreshToken) as? String,
				let _createdAt_Double	= userDefaults.object(forKey: UserDefaultsKeys.CreatedAt) as? Double,
				let _expiresIn			= userDefaults.object(forKey: UserDefaultsKeys.ExpiresIn) as? Int
				else { return nil }
			
			let object = OAuthObject(
				accessToken		: _accessToken,
				refreshToken	: _refreshToken,
				expiresIn		: _expiresIn,
				createdAt		: Date(timeIntervalSince1970: _createdAt_Double)
			)
			return object
		}
		
		public static func StoreObjectToUserDefaults(_ object: OAuthObject) {
			let userDefaults = UserDefaultsGetter()
			userDefaults.set(object.accessToken						, forKey: UserDefaultsKeys.AccessToken)
			userDefaults.set(object.refreshToken					, forKey: UserDefaultsKeys.RefreshToken)
			userDefaults.set(object.expiresIn						, forKey: UserDefaultsKeys.ExpiresIn)
			userDefaults.set(object.createdAt.timeIntervalSince1970	, forKey: UserDefaultsKeys.CreatedAt)
			userDefaults.synchronize()
		}
		
		public static func RemoveCurrentObjectFromUserDefaults() {
			let userDefaults = UserDefaultsGetter()
			userDefaults.set(nil, forKey: UserDefaultsKeys.AccessToken)
			userDefaults.set(nil, forKey: UserDefaultsKeys.RefreshToken)
			userDefaults.set(nil, forKey: UserDefaultsKeys.ExpiresIn)
			userDefaults.set(nil, forKey: UserDefaultsKeys.CreatedAt)
			userDefaults.synchronize()
		}
		
	}
	
}

extension IDMoya.OAuthObject {
	
	private final class UserDefaultsKeys {
		static let AccessToken		= "IDAM.UDK.AO.AT"
		static let RefreshToken		= "IDAM.UDK.AO.RT"
		static let ExpiresIn		= "IDAM.UDK.AO.EI"
		static let CreatedAt		= "IDAM.UDK.AO.CA"
	}
	
}

