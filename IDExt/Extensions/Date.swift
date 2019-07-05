//

import Foundation

public extension Date {
	
	public static var ID_Now: Date {
		return Date()
	}
	
	public func id_PersianDateString(with dateFormat: String = "yyyy/MM/dd") -> String {
		return DateFormatter.ID_Initialize(dateFormat: dateFormat).string(from: self)
	}
	
	public var id_IsToday: Bool {
		return Calendar.ID_Persian.isDateInToday(self)
	}
	
	public var id_IsYesterday: Bool {
		return Calendar.ID_Persian.isDateInYesterday(self)
	}
	
	public var id_IsTomorrow: Bool {
		return Calendar.ID_Persian.isDateInTomorrow(self)
	}
	
	public var id_BeautifulPersianDateString: String {
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
	
	public func id_Components(_ components: Set<Calendar.Component>, to date: Date, in calendar: Calendar = .current) -> DateComponents {
		return calendar.dateComponents(components, from: self, to: date)
	}
	
}
