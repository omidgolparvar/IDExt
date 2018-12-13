//
//  UITabBarItem.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/20/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UITabBarItem {
	
	public static func ID_SetTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any], for state: UIControl.State = UIControl.State()) {
		UITabBarItem.appearance().setTitleTextAttributes(attributes, for: state)
	}
	
}
