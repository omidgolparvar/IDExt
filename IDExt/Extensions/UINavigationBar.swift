//
//  UINavigationBar.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/20/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

extension UINavigationBar {
	
	public static func ID_SetTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]) {
		UINavigationBar.appearance().titleTextAttributes = attributes
	}
	
}
