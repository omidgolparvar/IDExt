//

import Foundation

public extension Error {
	
	public func id_PrintDescription(prefixMessage: String? = nil) {
		print("⚠️ IDExt - Error: \(prefixMessage ?? "") \(self.localizedDescription)")
	}
	
}
