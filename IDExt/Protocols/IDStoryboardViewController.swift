//

import Foundation
import UIKit

public protocol IDStoryboardViewController where Self: UIViewController {
	
	static var Storyboard				: UIStoryboard	{ get }
	static var ViewControllerIdentifer	: String		{ get }
	static var ViewControllerInstance	: Self			{ get }
	
}

public extension IDStoryboardViewController {
	
	public static var Storyboard: UIStoryboard {
		return UIStoryboard(name: "Main", bundle: .main)
	}
	
	public static var ViewControllerIdentifer: String {
		return "\(Self.self)"
	}
	
	public static var ViewControllerInstance: Self {
		return Storyboard
			.instantiateViewController(withIdentifier: self.ViewControllerIdentifer) as! Self
	}
	
}
