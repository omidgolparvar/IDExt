//

import Foundation

public extension Int {
	
	public var id_AsTimeString: String {
		var array: [String] = []
		let hour = self / 3600
		let minute = (self % 3600) / 60
		let second = (self % 3600) % 60
		
		let hourString: String
		if hour == 0 {
			hourString = ""
		} else if hour < 10 {
			hourString = "0\(hour)"
		} else {
			hourString = "\(hour)"
		}
		
		let minuteString: String
		if minute == 0 {
			minuteString = "00"
		} else if minute < 10 {
			minuteString = "0\(minute)"
		} else {
			minuteString = "\(minute)"
		}
		
		let secondString: String
		if second == 0 {
			secondString = "00"
		} else if second < 10 {
			secondString = "0\(second)"
		} else {
			secondString = "\(second)"
		}
		
		if !hourString.isEmpty { array.append(hourString) }
		array.append(minuteString)
		array.append(secondString)
		return array.joined(separator: ":")
	}
	
}
