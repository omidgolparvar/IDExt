//
//  Date.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/17/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension Date {
	
	public func id_AsPersianDateString(dateFormat: String = "yyyy/MM/dd") -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.calendar = Calendar.ID_Persian
		dateFormatter.locale = Locale.ID_Farsi
		dateFormatter.dateFormat = dateFormat
		return dateFormatter.string(from: self)
	}
	
}
