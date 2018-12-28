//
//  Int.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/25/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension Int {
	
	public var id_AsTimeString: String {
		var array: [String] = []
		let hour = self / 3600
		let minute = (self - (hour * 3600)) / 60
		let second = (self - (hour * 3600) - (minute * 60))
		let hourString = hour == 0 ? "" : "\(hour < 10 ? "0\(hour)" : "\(hour)")"
		let minuteString = minute == 0 ? "00" : "\(minute < 10 ? "0\(minute)" : "\(minute)")"
		let secondString = second == 0 ? "00" : "\(second < 10 ? "0\(second)" : "\(second)")"
		if !hourString.isEmpty { array.append(hourString) }
		array.append(minuteString)
		array.append(secondString)
		return array.joined(separator: ":")
	}
	
}
