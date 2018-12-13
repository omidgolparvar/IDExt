//
//  IDApplication.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/9/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public final class IDApplication {
	
	public static func GetUUID(storedInUserDefaults userDefaults: UserDefaults = .standard) -> String {
		let key = "__ID.Application.UUID"
		if let uuid = userDefaults.string(forKey: key) {
			return uuid
		}
		let uuid = UUID().uuidString
		userDefaults.id_Store(uuid, forKey: key)
		return uuid
	}
	
	public static var IsInDebugMode: Bool {
		#if DEBUG
			return true
		#else
			return false
		#endif
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
