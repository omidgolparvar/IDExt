//

import Foundation

public extension CGRect {
	
	public func id_SameFrame(withX x: CGFloat = 0, andY y: CGFloat = 0) -> CGRect {
		return .init(x: x, y: y, width: self.width, height: self.height)
	}
	
}
