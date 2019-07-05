//

import Foundation

public extension CGRect {
	
	public func id_SameWidthAndHight() -> CGRect {
		return .init(x: 0, y: 0, width: self.width, height: self.height)
	}
	
}
