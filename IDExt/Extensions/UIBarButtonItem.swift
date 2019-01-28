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
	
	public static func ID_SetupAppearance(font: UIFont, normalTextColor: UIColor, highlightedTextColor: UIColor) {
		let noramlAttributes		: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: normalTextColor]
		let highlightedAttributes	: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: highlightedTextColor]
		UIBarButtonItem.appearance().setTitleTextAttributes(noramlAttributes, for: .normal)
		UIBarButtonItem.appearance().setTitleTextAttributes(highlightedAttributes, for: .highlighted)
		
	}
	
}
