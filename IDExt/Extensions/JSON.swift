//
//  JSON.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/14/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftyJSON

public extension JSON {
	
	public func id_As<T: IDJSONIniti>(_ type: T.Type) -> T? {
		return T(fromJSONObject: self)
	}
	
	public var id_IntFromIntOrString: Int? {
		return self.int ?? Int(self.string ?? "//")
	}
	
	public var id_DataFromMilisecond: Date? {
		guard
			let timeInterval_String = self.string,
			let timeInterval_Int64 = Int64(timeInterval_String)
			else { return nil }
		return Date(timeIntervalSince1970: TimeInterval(timeInterval_Int64 / 1000))
		
	}
	
	public var id_DateFromSecond: Date? {
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
		guard let status = self["status"].id_IntFromIntOrString else { return false }
		return status == 1
	}
	
	public var id_Image: IDImage? {
		return IDImage(from: self)
	}
	
	public func id_DateFromString(basedOn dateFormatter: DateFormatter) -> Date? {
		guard let string = self.string else { return nil }
		return dateFormatter.date(from: string)
	}
	
}
