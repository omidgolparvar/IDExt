//
//  UIApplication.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIApplication {
	
	public static func ID_GetUUID(userDefaults: UserDefaults = .standard) -> String {
		let key = "ID.Application.UUID"
		if let uuid = userDefaults.string(forKey: key) {
			return uuid
		}
		let uuid = UUID().uuidString
		userDefaults.id_Store(uuid, forKey: key)
		return uuid
	}
	
	public static var ID_StatusBarView: UIView? {
		return UIApplication.shared.value(forKey: "statusBar") as? UIView
	}
	
	
	
	public func id_TopMostViewController() -> UIViewController? {
		return self.keyWindow?.rootViewController?.id_TopMostViewController()
	}
	
	public func id_Open(url: URL, completionHandler: ((Bool) -> Void)? = nil) {
		guard self.canOpenURL(url) else { return }
		self.open(url, options: [:], completionHandler: completionHandler)
	}
	
	public func id_RemoveAllNotificationsAndBadge() {
		self.applicationIconBadgeNumber = 1
		self.applicationIconBadgeNumber = 0
	}
	
	
	
	
}
