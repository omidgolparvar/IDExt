//
//  IDFont.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/21/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public final class IDFont {
	
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
		return IDFont.Font(ofSize: size, weight: .regular)
	}
	
	@objc
	public class func BoldSystemFont(ofSize size: CGFloat) -> UIFont {
		return IDFont.Font(ofSize: size, weight: .bold)
	}
	
	@objc
	public class func ItalicSystemFont(ofSize size: CGFloat) -> UIFont {
		return IDFont.Font(ofSize: size, weight: .regular)
	}
}
