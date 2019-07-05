//

import Foundation

public protocol IDType {}

public extension IDType where Self: Any {
	
	public var _Type_: Self.Type {
		return type(of: self)
	}
	
}

extension NSObject: IDType {}


