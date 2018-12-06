//
//  UITextField.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UITextField {
	
	public static func ID_SetDefaultTextAttributes(_ attributes: [NSAttributedString.Key: Any], whenContainedInInstancesOf containerTypes: [UIAppearanceContainer.Type]) {
		UITextField.appearance(whenContainedInInstancesOf: containerTypes).defaultTextAttributes = attributes
	}
	
	public func id_SetupDismissInputAccessoryView(viewController: UIViewController, title: String, font: UIFont, color: UIColor) {
		let toolbar = UIToolbar(dismissToolbarForViewController: viewController, doneButtonTitle: title, font: font, color: color)
		self.inputAccessoryView = toolbar
	}
	
}
