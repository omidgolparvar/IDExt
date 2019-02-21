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
		return UIApplication.shared.keyWindow?.rootViewController?.id_TopMostViewController
	}
	
	public static func ID_Open(url: URL, completionHandler: ((Bool) -> Void)? = nil) {
		guard UIApplication.shared.canOpenURL(url) else { return }
		UIApplication.shared.open(url, options: [:], completionHandler: completionHandler)
	}
	
	public static func ID_TryToOpen(url: URL, onFailed failureHandler: (() -> Void)? = nil) {
		guard UIApplication.shared.canOpenURL(url) else {
			failureHandler?()
			return
		}
		UIApplication.shared.open(url, options: [:], completionHandler: nil)
	}
	
	public static func ID_RemoveAllNotificationsAndBadge() {
		UIApplication.shared.applicationIconBadgeNumber = 0
	}
	
	public static func ID_SwitchRootViewController(
		to viewController	: UIViewController,
		animated			: Bool = true,
		duration			: TimeInterval = 0.5,
		options				: UIView.AnimationOptions = .transitionFlipFromRight,
		_ completion		: (() -> Void)? = nil) {
		
		guard let window = UIApplication.shared.keyWindow else { return }
		guard animated else {
			window.rootViewController = viewController
			completion?()
			return
		}
		
		UIView.transition(with: window, duration: duration, options: options, animations: {
			let oldState = UIView.areAnimationsEnabled
			UIView.setAnimationsEnabled(false)
			window.rootViewController = viewController
			UIView.setAnimationsEnabled(oldState)
		}, completion: { _ in
			completion?()
		})
	}
	
	
}
