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
				case "CTFontRegularUsage"		: fontName = UIFont.ID_Regular.fontName
				case "CTFontEmphasizedUsage",
					 "CTFontBoldUsage"			: fontName = UIFont.ID_Bold.fontName
				case "CTFontObliqueUsage"		: fontName = UIFont.ID_Regular.fontName
				default							: fontName = UIFont.ID_Regular.fontName
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
	
	public static func ID_OverrideInitialize() {
		if self == UIFont.self {
			if	let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
				let mySystemFontMethod = class_getClassMethod(self, #selector(ID_SystemFont)) {
				method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
			}
			
			if	let systemFontMethod_iOS9 = class_getClassMethod(self, #selector(systemFont(ofSize:weight:))),
				let mySystemFontMethod_iOS9 = class_getClassMethod(self, #selector(ID_SystemFont)) {
				method_exchangeImplementations(systemFontMethod_iOS9, mySystemFontMethod_iOS9)
			}
			
			if	let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
				let myBoldSystemFontMethod = class_getClassMethod(self, #selector(ID_BoldSystemFont)) {
				method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
			}
			
			if	let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
				let myItalicSystemFontMethod = class_getClassMethod(self, #selector(ID_ItalicSystemFont)) {
				method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
			}
			
			if	let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))),
				let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
				method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
			}
			
		}
	}
	
	
	public static var ID_Black		: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.black)
	public static var ID_Bold		: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
	public static var ID_Medium		: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
	public static var ID_Regular	: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
	public static var ID_Light		: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
	public static var ID_UltraLight	: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.ultraLight)
	
	public static func ID_SetFonts(
		black		: UIFont? = nil,
		bold		: UIFont,
		medium		: UIFont? = nil,
		regular		: UIFont,
		light		: UIFont? = nil,
		ultraLight	: UIFont? = nil
		) {
		if let __ = black { ID_Black = __ }
		ID_Bold = bold
		if let __ = medium { ID_Medium = __ }
		ID_Regular = regular
		if let __ = light { ID_Light = __ }
		if let __ = ultraLight { ID_UltraLight = __ }
	}
	
	public static func ID_Font(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
		switch weight {
		case .black			: return ID_Black.withSize(size)
		case .bold			: return ID_Bold.withSize(size)
		case .medium		: return ID_Medium.withSize(size)
		case .regular		: return ID_Regular.withSize(size)
		case .light			: return ID_Light.withSize(size)
		case .ultraLight	: return ID_UltraLight.withSize(size)
		default				: return ID_Regular.withSize(size)
		}
	}
	
	@objc
	public class func ID_SystemFont(ofSize size: CGFloat) -> UIFont {
		return ID_Font(ofSize: size, weight: .regular)
	}
	
	@objc
	public class func ID_BoldSystemFont(ofSize size: CGFloat) -> UIFont {
		return ID_Font(ofSize: size, weight: .bold)
	}
	
	@objc
	public class func ID_ItalicSystemFont(ofSize size: CGFloat) -> UIFont {
		return ID_Font(ofSize: size, weight: .regular)
	}
	
}
