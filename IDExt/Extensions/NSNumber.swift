//
//  NSNumber.swift
//  IDExt
//
//  Created by Omid Golparvar on 2/18/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation


public extension NSNumber {
	
	public func id_FormattedString(numberStyle: NumberFormatter.Style, locale: Locale = .ID_Farsi) -> String {
		let numberFormatter = NumberFormatter()
		numberFormatter.locale = locale
		numberFormatter.numberStyle = numberStyle
		return numberFormatter.string(from: self)!
	}
	
}
