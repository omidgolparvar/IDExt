//
//  UITabBarItem.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/20/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UITabBarItem {
	
	public static func ID_SetTitleAppearance(font: UIFont, textColor: UIColor, for state: UIControl.State) {
		let attributes: [NSAttributedString.Key: Any] = [
			.font 				: font,
			.foregroundColor	: textColor
		]
		UITabBarItem.appearance().setTitleTextAttributes(attributes, for: state)
	}
	
}
