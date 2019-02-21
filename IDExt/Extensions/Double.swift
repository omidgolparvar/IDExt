//
//  Double.swift
//  IDExt
//
//  Created by Omid Golparvar on 2/18/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

public extension Double {
	
	public var id_AsNSNumber: NSNumber {
		return NSNumber(value: self)
	}
	
	public func id_Rounded(toPlaces places:Int) -> Double {
		guard places >= 0 else { return self }
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
	
}
