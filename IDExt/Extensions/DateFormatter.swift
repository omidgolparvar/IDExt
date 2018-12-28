//
//  DateFormatter.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/23/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension DateFormatter {
	
	public static var ID_BasedOnPersianLanguage: DateFormatter {
		return ID_Initialize(calendar: .ID_Persian, locale: .ID_Farsi, dateFormat: "yyyy/MM/dd HH:mm")
	}
	
	public static func ID_Initialize(calendar: Calendar = .ID_Persian, locale: Locale = .ID_Farsi, dateFormat: String) -> DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.calendar = calendar
		dateFormatter.locale = locale
		dateFormatter.dateFormat = dateFormat
		return dateFormatter
	}
	
}
