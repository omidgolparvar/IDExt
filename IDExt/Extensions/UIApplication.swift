//
//  UIApplication.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDApplicationDelegate: NSObjectProtocol {
	var idApplication_UsingUserDefaults	: UserDefaults	{ get }
	var idApplication_OneSignalPlayerID	: String?		{ get }
}

public extension IDApplicationDelegate {
	var idApplication_UsingUserDefaults	: UserDefaults	{ return .standard }
	var idApplication_OneSignalPlayerID	: String?		{ return nil }
}

public extension UIApplication {
	
	public static weak var SharedDelegate: IDApplicationDelegate?
	
	public typealias ApplicationVersion = (version: String, buildNumber: String)
	public static var ID_ApplicationVersion: ApplicationVersion {
		let infoDictionary = Bundle.main.infoDictionary
		let version = infoDictionary?["CFBundleShortVersionString"] as? String
		let buildNumber = infoDictionary?["CFBundleVersion"] as? String
		return (version ?? "", buildNumber ?? "")
	}
	
	public static var ID_FullVersionAndBuildNumber: String {
		let version = ID_ApplicationVersion
		return version.version + "[\(version.buildNumber)]"
	}
	
	public static var ID_IsDebugMode: Bool {
		#if DEBUG
		return true
		#else
		return false
		#endif
	}
	
	public static var ID_UUID: String {
		guard let delegate = UIApplication.SharedDelegate else {
			fatalError("⚠️ UIApplication: SharedDelegate is NIL.")
		}
		let userDefaults = delegate.idApplication_UsingUserDefaults
		let key = "__ID.Application.UUID"
		if let uuid = userDefaults.string(forKey: key) {
			return uuid
		}
		let uuid = UUID().uuidString
		userDefaults.set(uuid, forKey: key)
		return uuid
	}
	
	public static var ID_OneSignalPlayerID: String? {
		guard let delegate = UIApplication.SharedDelegate else {
			fatalError("⚠️ UIApplication: SharedDelegate is NIL.")
		}
		return delegate.idApplication_OneSignalPlayerID
	}
	
	public static func ID_Value<T>(development: T?, production: T?) -> T? {
		return ID_IsDebugMode ? development : production
	}
	
	public static func ID_OnlyInProductionMode(_ closure: () -> Void) {
		guard !ID_IsDebugMode else { return }
		closure()
	}
	
	public static func ID_OnlyInDevelopmentMode(_ closure: () -> Void) {
		guard ID_IsDebugMode else { return }
		closure()
	}
	
	public static func ID_OnlyOnSimulator(_ closure: () -> Void) {
		guard UIDevice.ID_IsSimulator else { return }
		closure()
	}
	
	public static func ID_OnlyOnRealDevice(_ closure: () -> Void) {
		guard !UIDevice.ID_IsSimulator else { return }
		closure()
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
	
	public static func ID_TryToOpen(url: URL, onFailure failureHandler: (() -> Void)? = nil) {
		guard UIApplication.shared.canOpenURL(url) else {
			failureHandler?()
			return
		}
		UIApplication.shared.open(url, options: [:], completionHandler: nil)
	}
	
	public static func ID_RemoveAllNotificationsAndBadge() {
		UIApplication.shared.applicationIconBadgeNumber = 0
	}
	
	public enum IDSwitchRootViewControllerTransition {
		case instantly
		case animated(duration: TimeInterval, options: UIView.AnimationOptions)
	}
	public static func ID_SwitchRootViewController(target: UIViewController, transition: IDSwitchRootViewControllerTransition, completion: (() -> Void)? = nil) {
		guard let window = UIApplication.shared.keyWindow else { return }
		
		switch transition {
		case .instantly:
			window.rootViewController = target
			completion?()
		case .animated(let duration, let options):
			UIView.transition(with: window, duration: duration, options: options, animations: {
				let oldState = UIView.areAnimationsEnabled
				UIView.setAnimationsEnabled(false)
				window.rootViewController = target
				UIView.setAnimationsEnabled(oldState)
			}, completion: { _ in
				completion?()
			})
		}
	}
	
	
	
	
	
}
