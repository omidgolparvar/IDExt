//
//  Date.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/17/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension Date {
	
	public static var ID_Now: Date {
		return Date()
	}
	
	public func id_AsPersianDateString(dateFormat: String = "yyyy/MM/dd") -> String {
		return DateFormatter.ID_Initialize(dateFormat: dateFormat).string(from: self)
	}
	
	public var id_IsToday: Bool {
		return Calendar.current.isDateInToday(self)
	}
	
	public var id_IsYesterday: Bool {
		return Calendar.current.isDateInYesterday(self)
	}
	
	public var id_IsTomorrow: Bool {
		return Calendar.current.isDateInTomorrow(self)
	}
	
	public var id_BeautifulString: String {
		if self.id_IsYesterday {
			return DateFormatter.ID_Initialize(dateFormat: "دیروز، HH:mm").string(from: self)
		}
		
		if self.id_IsToday {
			return DateFormatter.ID_Initialize(dateFormat: "امروز، HH:mm").string(from: self)
		}
		
		if self.id_IsTomorrow {
			return DateFormatter.ID_Initialize(dateFormat: "فردا، HH:mm").string(from: self)
		}
		
		return DateFormatter.ID_Initialize(dateFormat: "d MMMM، HH:mm").string(from: self)
	}
	
}
