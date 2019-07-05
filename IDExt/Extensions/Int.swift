//

import Foundation

public extension Int {
	
	public var id_ConvertedFromSecondToTimeString: String {
		var secondComponent = DateComponents()
		secondComponent.second = self
		
		let date = Calendar.ID_Persian.date(from: secondComponent)!
		let dateFormatter = DateFormatter()
		dateFormatter.calendar = .ID_Persian
		dateFormatter.dateFormat = "HH:mm:ss"
		
		return dateFormatter.string(from: date)
	}
	
}
