//
//  UIViewController.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SafariServices

public extension UIViewController {
	
	public static func ID_Initialize(bundle: Bundle? = nil, storyboard: String, identifier: String) -> UIViewController {
		return UIStoryboard(name: storyboard, bundle: bundle).instantiateViewController(withIdentifier: identifier)
	}
	
	public static func ID_Initialize(bundle: Bundle? = nil, pattern: String) -> UIViewController {
		let components = pattern.components(separatedBy: "|").map({ $0.id_Trimmed }).filter({ !$0.isEmpty })
		guard components.count == 2 else {
			fatalError("⚠️ IDExt.UIViewController.ID_Initialize: Pattern should be : {StoryboardName}|{ViewControllerIdentifier}")
		}
		let storyboardName = components[0]
		let identifier = components[1]
		return UIStoryboard(name: storyboardName, bundle: bundle).instantiateViewController(withIdentifier: identifier)
	}
	
	public static func ID_Initialize<T: IDStoryboardInstanceProtocol>(_ type: T.Type) -> T {
		return type.IDViewControllerInstance
	}
	
	
	
	public var id_TopMostViewController: UIViewController {
		
		if let navigation = self as? UINavigationController {
			return navigation.visibleViewController!.id_TopMostViewController
		}
		
		if let tab = self as? UITabBarController {
			if let selectedTab = tab.selectedViewController {
				return selectedTab.id_TopMostViewController
			}
			return tab.id_TopMostViewController
		}
		
		if self.presentedViewController == nil {
			return self
		}
		
		if let navigation = self.presentedViewController as? UINavigationController {
			return navigation.visibleViewController!.id_TopMostViewController
		}
		
		if let tab = self.presentedViewController as? UITabBarController {
			if let selectedTab = tab.selectedViewController {
				return selectedTab.id_TopMostViewController
			}
			return tab.id_TopMostViewController
		}
		
		return self.presentedViewController!.id_TopMostViewController
	}
	
	@objc
	public func id_EndEditing() {
		self.view.endEditing(true)
	}
	
	@objc
	public func id_Dismiss() {
		self.dismiss(animated: true, completion: nil)
	}
	
	public typealias IDNotificationObserver = (notificationName: Notification.Name, selector: Selector)
	public func id_AddObservers(_ items: [IDNotificationObserver]) {
		items.forEach {
			NotificationCenter.default.addObserver(self, selector: $0.selector, name: $0.notificationName, object: nil)
		}
	}
	
	public func id_ObservationBlock(for notificationName: Notification.Name, closure: @escaping (Notification) -> Void) {
		NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: nil, using: closure)
	}
	
	public func id_RemoveAllObservers() {
		NotificationCenter.default.removeObserver(self)
	}
	
	public func id_RemoveObserver(for notificationName: Notification.Name) {
		NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
	}
	
	public func id_PresentActivityController(for items: [Any], sourceView: UIView? = nil, permittedArrowDirections: UIPopoverArrowDirection = .unknown) {
		let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
		activityViewController.popoverPresentationController?.sourceView = sourceView ?? self.view
		activityViewController.popoverPresentationController?.sourceRect = sourceView?.bounds ?? self.view.bounds
		activityViewController.popoverPresentationController?.permittedArrowDirections = permittedArrowDirections
		self.present(activityViewController, animated: true, completion: nil)
	}
	
	public func id_PresentActivityController(for items: [Any], barButtonItem: UIBarButtonItem) {
		let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
		activityViewController.popoverPresentationController?.sourceView = self.view
		activityViewController.popoverPresentationController?.sourceRect = self.view.bounds
		activityViewController.popoverPresentationController?.barButtonItem = barButtonItem
		activityViewController.popoverPresentationController?.permittedArrowDirections = .down
		self.present(activityViewController, animated: true, completion: nil)
	}
	
	public func id_OpenSafariViewController(for url: URL, delegate: SFSafariViewControllerDelegate? = nil) {
		guard ["http", "https"].contains(url.scheme?.lowercased() ?? "") else { return }
		let vc = SFSafariViewController(url: url, entersReaderIfAvailable: false)
		vc.delegate = delegate
		present(vc, animated: true)
	}
	
	public func id_SetAsKeyWindowRootViewController() {
		UIApplication.shared.keyWindow?.rootViewController = self
	}
	
	@available(iOS 11.0, *)
	public func id_ChangeLargeTitleDirection() {
		self.navigationController?.navigationBar.subviews[safe: 1]?.semanticContentAttribute = .forceRightToLeft
	}
	
	public func id_SetupTapGestureForEndEditing() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(id_EndEditing))
		self.view.addGestureRecognizer(tapGesture)
	}
	
	public var id_IsModal: Bool {
		if let navigationController = self.navigationController {
			if navigationController.viewControllers.first != self {
				return false
			}
		}
		
		if self.presentingViewController != nil {
			return true
		}
		
		if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
			return true
		}
		
		if self.tabBarController?.presentingViewController is UITabBarController {
			return true
		}
		
		return false
	}
	
}

