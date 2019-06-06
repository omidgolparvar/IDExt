//
//  UITextView.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UITextView {
	
	public func id_SetupDismissInputAccessoryView(viewController: UIViewController, title: String, font: UIFont, color: UIColor) {
		let toolbar = UIToolbar(dismissToolbarForViewController: viewController, title: title, font: font, color: color)
		self.inputAccessoryView = toolbar
	}
	
}
