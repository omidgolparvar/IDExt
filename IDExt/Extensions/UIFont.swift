//
//  UIFont.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIFont {
	
	public final class ID_Font {
		
		public static var Black			: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.black)
		public static var Bold			: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
		public static var Medium		: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
		public static var Regular		: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
		public static var Light			: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
		public static var UltraLight	: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.ultraLight)
		
		public static func SetFonts(
				black		: UIFont? = nil,
				bold		: UIFont,
				medium		: UIFont? = nil,
				regular		: UIFont,
				light		: UIFont? = nil,
				ultraLight	: UIFont? = nil
			) {
			if let __ = black { Black = __ }
			Bold = bold
			if let __ = medium { Medium = __ }
			Regular = regular
			if let __ = light { Light = __ }
			if let __ = ultraLight { UltraLight = __ }
		}
		
		public static func Font(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
			switch weight {
			case .black			: return Black.withSize(size)
			case .bold			: return Bold.withSize(size)
			case .medium		: return Medium.withSize(size)
			case .regular		: return Regular.withSize(size)
			case .light			: return Light.withSize(size)
			case .ultraLight	: return UltraLight.withSize(size)
			default				: return Regular.withSize(size)
			}
		}
		
		@objc
		public class func SystemFont(ofSize size: CGFloat) -> UIFont {
			return ID_Font.Font(ofSize: size, weight: .regular)
		}
		
		@objc
		public class func BoldSystemFont(ofSize size: CGFloat) -> UIFont {
			return ID_Font.Font(ofSize: size, weight: .bold)
		}
		
		@objc
		public class func ItalicSystemFont(ofSize size: CGFloat) -> UIFont {
			return ID_Font.Font(ofSize: size, weight: .regular)
		}
	}
	
	@objc
	public convenience init(myCoder aDecoder: NSCoder) {
		if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
			let fontAttribute = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
			if let fontAttribute = fontDescriptor.fontAttributes[fontAttribute] as? String {
				var fontName = ""
				switch fontAttribute {
				case "CTFontRegularUsage"	: fontName = UIFont.ID_Font.Regular.fontName
				case "CTFontEmphasizedUsage",
					 "CTFontBoldUsage"		: fontName = UIFont.ID_Font.Bold.fontName
				case "CTFontObliqueUsage"	:fontName = UIFont.ID_Font.Regular.fontName
				default						: fontName = UIFont.ID_Font.Regular.fontName
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
				let mySystemFontMethod = class_getClassMethod(self, #selector(ID_Font.SystemFont)) {
				method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
			}
			
			if	let systemFontMethod_iOS9 = class_getClassMethod(self, #selector(systemFont(ofSize:weight:))),
				let mySystemFontMethod_iOS9 = class_getClassMethod(self, #selector(ID_Font.SystemFont)) {
				method_exchangeImplementations(systemFontMethod_iOS9, mySystemFontMethod_iOS9)
			}
			
			if	let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
				let myBoldSystemFontMethod = class_getClassMethod(self, #selector(ID_Font.BoldSystemFont)) {
				method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
			}
			
			if	let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
				let myItalicSystemFontMethod = class_getClassMethod(self, #selector(ID_Font.ItalicSystemFont)) {
				method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
			}
			
			if	let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))),
				let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
				method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
			}
			
		}
	}
	
}
