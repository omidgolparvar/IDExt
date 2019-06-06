//

import Foundation
import UIKit

public extension UIViewController {
	
	public func id_Route(to destination: UIViewController, with type: IDRouter.RoutingType) {
		IDRouter.Present(source: self, destination: destination, type: type)
	}
	
}
