//

import Foundation

public extension Array {
	
	public func id_Enumerate(_ closure: (Int, Element) -> Void) {
		self.enumerated().forEach { (index, element) in closure(index, element) }
	}
	
	
	public subscript(safe index: Int) -> Element? {
		get {
			guard 0..<count ~= index else { return nil }
			return self[index]
		}
	}
	
}
