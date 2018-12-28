//
//  IDDeekLinkHandlerProtocol.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/25/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDDeekLinkHandlerProtocol {
	
	static func ID_CanHandle(url: URL)							-> Bool
	static func ID_GetDeepLinkObject(from url: URL)				-> IDDeekLinkObject?
	static func ID_Handle(deeplink object: IDDeekLinkObject)	-> Bool
	
}

public extension IDDeekLinkHandlerProtocol {
	
	public static func ID_CanHandle(url: URL)					-> Bool {
		guard let object = ID_GetDeepLinkObject(from: url) else { return false }
		return ID_Handle(deeplink: object)
	}
	
}

public protocol IDDeekLinkObject {
	
}
