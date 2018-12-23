//
//  IDUser+Models.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/19/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension IDUser {
	
	public enum InitType {
		case raw
		case data(AnyObject?)
		case userDefaults
		case authObject(IDMoya.OAuthObject)
	}
	
	public final class NotificationKeys {
		
		public static var User_LoggedIn: Notification.Name { return .init("IDUser.NN.User_LoggedIn") }
		
	}
	
}
