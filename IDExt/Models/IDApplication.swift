//
//  IDApplication.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/9/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public final class IDApplication {
	
	public static var UsingUserDefaultsGetter: () -> UserDefaults = { return .standard }
	
	public static var OneSignalPlayerIDGetter: () -> String? = { return nil }
	
	public static var IsInDebugMode: Bool {
		#if DEBUG
		return true
		#else
		return false
		#endif
	}
	
	public static func GetUUID(storedInUserDefaults userDefaults: UserDefaults = UsingUserDefaultsGetter()) -> String {
		let key = "__ID.Application.UUID"
		if let uuid = userDefaults.string(forKey: key) {
			return uuid
		}
		let uuid = UUID().uuidString
		userDefaults.id_Store(uuid, forKey: key)
		return uuid
	}
	
	public static func Value<T>(development: T?, production: T?) -> T? {
		return IsInDebugMode ? development : production
	}
	
	public static func OnlyInProductionMode(closure: () -> Void) {
		guard !IsInDebugMode else { return }
		closure()
	}
	
	public static func OnlyInDevelopmentMode(closure: () -> Void) {
		guard IsInDebugMode else { return }
		closure()
	}
	
}
