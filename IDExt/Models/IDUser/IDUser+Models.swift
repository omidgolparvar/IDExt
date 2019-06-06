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
		case data(Any?)
		case userDefaults
		case authObject(IDMoya.OAuthObject)
	}
	
}

public extension Notification.Name {
	
	public static var IDUser_User_LoggedIn	: Notification.Name { return .init("IDUser.NN.User_LoggedIn") }
	public static var IDUser_User_LoggedOut	: Notification.Name { return .init("IDUser.NN.User_LoggedOut") }
	
}
