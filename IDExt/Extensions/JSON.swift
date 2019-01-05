//
//  JSON.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/14/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftyJSON
import PersianSwift

public extension JSON {
	
	public var id_IntFromIntOrString: Int? {
		return self.int ?? Int(self.string ?? "//")
	}
	
	public var id_DoubleFromDoubleOrString: Double? {
		return self.double ?? Double(self.string ?? "//")
	}
	
	public var id_BooleanFromBoolOrIntOrString: Bool? {
		if let boolValue	= self.bool		{ return boolValue }
		if let intValue		= self.int		{ return intValue == 1 }
		if let stringValue	= self.string	{ return stringValue == "1" }
		return nil
	}
	
	public var id_DateBasedOnMilisecond: Date? {
		guard
			let timeInterval_String = self.string,
			let timeInterval_Int64 = Int64(timeInterval_String)
			else { return nil }
		return Date(timeIntervalSince1970: TimeInterval(timeInterval_Int64 / 1000))
		
	}
	
	public var id_DateBasedOnSecond: Date? {
		if	let timeInterval_String = self.string,
			let timeInterval_Double = Double(timeInterval_String) {
			return Date(timeIntervalSince1970: timeInterval_Double)
		}
		if	let timeInterval_Double = self.double {
			return Date(timeIntervalSince1970: timeInterval_Double)
		}
		return nil
	}
	
	public var id_HasStatusWithSuccessfulValue: Bool {
		return self["status"].id_BooleanFromBoolOrIntOrString ?? false
	}
	
	public var id_Image: IDImage? {
		return IDImage(from: self)
	}
	
	public var id_DynamicJSON: IDDynamicJSON {
		return IDDynamicJSON(from: self)
	}
	
	public var id_StringWithPersianDigits: String? {
		return self.string?.ps.withPersianDigits
	}
	
	
	public func id_As<T: IDJSONInitBased>(_ type: T.Type) -> T? {
		return T(fromJSONObject: self)
	}
	
	public func id_DateFromString(basedOn dateFormatter: DateFormatter) -> Date? {
		guard let string = self.string else { return nil }
		return dateFormatter.date(from: string)
	}
	
	public func id_Print() {
		print(self)
	}
	
}

