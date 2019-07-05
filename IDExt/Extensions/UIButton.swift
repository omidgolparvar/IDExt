//
//  UIButton.swift
//  IDExt
//
//  Created by Omid Golparvar on 3/6/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIButton {
	
	public func id_SetupTitle(text: String, font: UIFont, textColor: UIColor, for state: UIControl.State) {
		let attributedTitle = NSAttributedString(string: text, attributes: [.font: font, .foregroundColor: textColor])
		self.setAttributedTitle(attributedTitle, for: state)
		self.setNeedsLayout()
		self.layoutIfNeeded()
	}
	
	public func id_SetupTitleAppearance(text: String, font: UIFont, textColor: UIColor) {
		let attributedTitle = NSAttributedString(string: text, attributes: [.font: font, .foregroundColor: textColor])
		self.setAttributedTitle(attributedTitle, for: .normal)
		self.setAttributedTitle(attributedTitle, for: .highlighted)
		self.setNeedsLayout()
		self.layoutIfNeeded()
	}
	
}
