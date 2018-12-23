//
//  UIFont.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIFont {
	
	@objc
	public convenience init(myCoder aDecoder: NSCoder) {
		if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
			let fontAttribute = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
			if let fontAttribute = fontDescriptor.fontAttributes[fontAttribute] as? String {
				var fontName = ""
				switch fontAttribute {
				case "CTFontRegularUsage"		: fontName = IDFont.Regular.fontName
				case "CTFontEmphasizedUsage",
					 "CTFontBoldUsage"			: fontName = IDFont.Bold.fontName
				case "CTFontObliqueUsage"		: fontName = IDFont.Regular.fontName
				default							: fontName = IDFont.Regular.fontName
				}
				self.init(name: fontName, size: fontDescriptor.pointSize)!
			}
			else {
				self.init(myCoder: aDecoder)
			}
		} else {
			self.init(myCoder: aDecoder)
		}
	}
	
	public class func ID_OverrideInitialize() {
		if self == UIFont.self {
			if	let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
				let mySystemFontMethod = class_getClassMethod(self, #selector(IDFont.SystemFont)) {
				method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
			}
			
			if	let systemFontMethod_iOS9 = class_getClassMethod(self, #selector(systemFont(ofSize:weight:))),
				let mySystemFontMethod_iOS9 = class_getClassMethod(self, #selector(IDFont.SystemFont)) {
				method_exchangeImplementations(systemFontMethod_iOS9, mySystemFontMethod_iOS9)
			}
			
			if	let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
				let myBoldSystemFontMethod = class_getClassMethod(self, #selector(IDFont.BoldSystemFont)) {
				method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
			}
			
			if	let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
				let myItalicSystemFontMethod = class_getClassMethod(self, #selector(IDFont.ItalicSystemFont)) {
				method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
			}
			
			if	let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))),
				let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
				method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
			}
			
		}
	}
	
}
