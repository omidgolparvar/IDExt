//
//  UNMutableNotificationContent.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/30/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import UserNotifications

public extension UNMutableNotificationContent {
	
	public static func ID_Initialize(
		title		: String,
		body		: String,
		badge		: NSNumber? = nil,
		sound		: UNNotificationSound = .default,
		userInfo	: [AnyHashable: Any] = [:]
		) -> UNMutableNotificationContent {
		
		let content = UNMutableNotificationContent()
		content.title = title
		content.body = body
		content.badge = badge
		content.sound = sound
		content.userInfo = userInfo
		return content
	}
	
}
