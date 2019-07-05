//

import Foundation

public extension DateFormatter {
	
	public static func ID_Initialize(calendar: Calendar = .ID_Persian, locale: Locale = .ID_Farsi, dateFormat: String = "yyyy/MM/dd HH:mm") -> DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.calendar = calendar
		dateFormatter.locale = locale
		dateFormatter.dateFormat = dateFormat
		return dateFormatter
	}
	
}
