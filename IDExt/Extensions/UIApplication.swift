//
//  UIApplication.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIApplication {
	
	public static var ID_ApplicationVersion: (version: String, buildNumber: String) {
		let _version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
		let _buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
		return (_version ?? "", _buildNumber ?? "")
	}
	
	public static var ID_FullVersionAndBuildNumber: String {
		let version = ID_ApplicationVersion
		return version.version + "[\(version.buildNumber)]"
	}
	
	public static var ID_StatusBarView: UIView? {
		return UIApplication.shared.value(forKey: "statusBar") as? UIView
	}
	
	public static var ID_TopMostViewController: UIViewController? {
		return UIApplication.shared.keyWindow?.rootViewController?.id_TopMostViewController()
	}
	
	public static func ID_Open(url: URL, completionHandler: ((Bool) -> Void)? = nil) {
		guard UIApplication.shared.canOpenURL(url) else { return }
		UIApplication.shared.open(url, options: [:], completionHandler: completionHandler)
	}
	
	public static func ID_RemoveAllNotificationsAndBadge() {
		UIApplication.shared.applicationIconBadgeNumber = 0
	}
	
}
