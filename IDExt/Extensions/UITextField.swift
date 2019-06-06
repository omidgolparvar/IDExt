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
		let toolbar = UIToolbar(dismissToolbarForViewController: viewController, title: title, font: font, color: color)
		self.inputAccessoryView = toolbar
	}
	
	public func id_SetRightView(_ view: UIView, mode: UITextField.ViewMode = .always) {
		self.rightView = view
		self.rightViewMode = mode
	}
	
	public func id_SetLeftView(_ view: UIView, mode: UITextField.ViewMode = .always) {
		self.leftView = view
		self.leftViewMode = mode
	}
	
	public func id_SetSidePadding(left: CGFloat, right: CGFloat) {
		let leftPaddingView = UIView(frame: .init(x: 0, y: 0, width: left, height: self.frame.height))
		let rightPaddingView = UIView(frame: .init(x: 0, y: 0, width: right, height: self.frame.height))
		self.id_SetLeftView(leftPaddingView)
		self.id_SetRightView(rightPaddingView)
	}
	
	public func id_SetSidePadding(_ padding: CGFloat) {
		self.id_SetSidePadding(left: padding, right: padding)
	}
	
	public func id_SetLeftText(_ text: String, font: UIFont, textColor: UIColor) {
		let nsString = text as NSString
		let size = nsString.size(withAttributes: [.font: font])
		let label = UILabel(frame: .init(x: 0, y: 0, width: size.width + 16, height: self.frame.height))
		label.text = text
		label.font = font
		label.textColor = textColor
		label.textAlignment = .center
		self.id_SetLeftView(label)
	}
	
	public func id_SetRightText(_ text: String, font: UIFont, textColor: UIColor) {
		let nsString = text as NSString
		let size = nsString.size(withAttributes: [.font: font])
		let label = UILabel(frame: .init(x: 0, y: 0, width: size.width + 16, height: self.frame.height))
		label.text = text
		label.font = font
		label.textColor = textColor
		label.textAlignment = .center
		self.id_SetRightView(label)
	}
	
	public func id_GetMobileFromText() -> String? {
		guard let text = self.text?.id_Trimmed.ps.withEasternDigits, !text.isEmpty, text.ps.isPersianPhoneNumber else { return nil }
		return text
	}
	
	public func id_SetupTextWithPersianDigitsAndCurrencyStyle() {
		self.text = (self.text ?? "")
			.ps.withEasternDigits
			.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
			.ps.withCurrencyStyle
	}
	
	public func id_SetupPlaceholder(color: UIColor, text: String? = nil) {
		let placeholderText = text ?? self.placeholder ?? ""
		self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [.foregroundColor: color])
	}
	
}
