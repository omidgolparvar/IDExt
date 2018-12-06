//
//  UIColor.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIColor {
	
	public static func ID_Initialize(hexCode: String) -> UIColor {
		var colorCode: String = hexCode
		
		if (colorCode.hasPrefix("#")) {
			let startIndex = colorCode.index(colorCode.startIndex, offsetBy: 1)
			colorCode = String(colorCode[startIndex...])
		}
		
		var rgbValue: UInt32 = 0
		Scanner(string: colorCode).scanHexInt32(&rgbValue)
		
		return UIColor.init(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
	
	
	/**
	Construct a UIColor using an HTML/CSS RGB formatted value and an alpha value
	
	:param: rgbValue RGB value
	:param: alpha color alpha value
	
	:returns: an UIColor instance that represent the required color
	*/
	public static func ID_ColorWithRGB(rgbValue: UInt, alpha: CGFloat = 1.0) -> UIColor {
		let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
		let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255
		let blue = CGFloat(rgbValue & 0xFF) / 255
		
		return UIColor(red: red, green: green, blue: blue, alpha: alpha)
	}
	
	/**
	Returns a lighter color by the provided percentage
	
	:param: lighting percent percentage
	:returns: lighter UIColor
	*/
	public func id_LighterColor(percent : Double) -> UIColor {
		return id_ColorWithBrightnessFactor(factor: CGFloat(1 + percent));
	}
	
	/**
	Returns a darker color by the provided percentage
	
	:param: darking percent percentage
	:returns: darker UIColor
	*/
	public func id_DarkerColor(percent : Double) -> UIColor {
		return id_ColorWithBrightnessFactor(factor: CGFloat(1 - percent));
	}
	
	/**
	Return a modified color using the brightness factor provided
	
	:param: factor brightness factor
	:returns: modified color
	*/
	public func id_ColorWithBrightnessFactor(factor: CGFloat) -> UIColor {
		var hue : CGFloat = 0
		var saturation : CGFloat = 0
		var brightness : CGFloat = 0
		var alpha : CGFloat = 0
		
		if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
			return UIColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
		} else {
			return self;
		}
	}
	
}
