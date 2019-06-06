//
//  IDHelper.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/10/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import UIDeviceComplete
import UserNotifications

public final class IDHelper {
	
	public static func DetailedPrint(_ item: Any, file: String = #file, function: String = #function, line: Int = #line) {
		#if DEBUG
			let fileName = file.components(separatedBy: "/")
			print("""
			[\(fileName.isEmpty ? "" : fileName.last!)] : #\(line) : \(function)
			\(item)
			""")
			return
		#else
			return
		#endif
	}
	
	public static func DebugPrint(_ item: Any) {
		#if DEBUG
			print(item)
			return
		#else
			return
		#endif
	}
	
	public static func SetupAutolayoutMessages(isEnable: Bool) {
		UserDefaults.standard.set(isEnable ? nil : false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
	}
	
	public static func AddNotification(identifier: String = UUID().uuidString, title: String, body: String, delay: TimeInterval, completionHandler: ((Error?) -> Void)? = nil) {
		guard !identifier.id_Trimmed.isEmpty else {
			print("IDHelper.CreateLocalNotification: Identifier is empty; Notification NOT created.")
			return
		}
		let center = UNUserNotificationCenter.current()
		let content = UNMutableNotificationContent()
		content.title = title
		content.body = body
		content.sound = .default
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
		let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
		center.add(request, withCompletionHandler: completionHandler)
	}
	
	public static func AddNotification(content: UNMutableNotificationContent, identifier: String = UUID().uuidString, delay: TimeInterval, completionHandler: ((Error?) -> Void)? = nil) {
		guard !identifier.id_Trimmed.isEmpty else {
			print("IDHelper.CreateLocalNotification: Identifier is empty; Notification NOT created.")
			return
		}
		let center = UNUserNotificationCenter.current()
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
		let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
		center.add(request, withCompletionHandler: completionHandler)
	}
	
}
