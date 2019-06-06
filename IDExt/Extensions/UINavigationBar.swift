//
//  UINavigationBar.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/20/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UINavigationBar {
	
	public static func ID_SetTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]) {
		UINavigationBar.appearance().titleTextAttributes = attributes
	}
	
	public static func ID_SetupTitleAppearance(font: UIFont, textColor: UIColor) {
		let attributes: [NSAttributedString.Key: Any] = [
			.font 				: font,
			.foregroundColor	: textColor
		]
		UINavigationBar.appearance().titleTextAttributes = attributes
	}
	
	@available(iOS 11.0, *)
	public static func ID_SetupLargeTitleAppearance(font: UIFont, textColor: UIColor) {
		let attributes: [NSAttributedString.Key: Any] = [
			.font 				: font,
			.foregroundColor	: textColor
		]
		UINavigationBar.appearance().largeTitleTextAttributes = attributes
	}
	
}
