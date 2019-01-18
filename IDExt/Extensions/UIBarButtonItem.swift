//
//  UIBarButtonItem.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/20/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIBarButtonItem {
	
	public static func ID_SetTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any], for state: UIControl.State = .normal) {
		UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: state)
	}
	
}
