//
//  UIToolbar.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/2/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

extension UIToolbar {
	
	public convenience init(dismissToolbarForViewController viewController: UIViewController, doneButtonTitle title: String, font: UIFont, color: UIColor) {
		self.init(frame: CGRect(x: 0, y: 0,  width: viewController.view.frame.size.width, height: 30))
		let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let doneButton = UIBarButtonItem(title: title, style: .done, target: viewController, action: #selector(viewController.id_EndEditing))
		doneButton.setTitleTextAttributes([.font: font, .foregroundColor: color], for: .normal)
		self.setItems([flexSpace, doneButton], animated: false)
		self.sizeToFit()
	}
	
}
