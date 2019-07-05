//

import Foundation
import UIKit

public protocol IDStoryboardViewController where Self: UIViewController {
	
	static var StoryboardName			: String	{ get }
	static var ViewControllerIdentifer	: String	{ get }
	static var ViewControllerInstance	: Self		{ get }
	
}

public extension IDStoryboardViewController {
	
	public static var StoryboardName: String {
		return "Main"
	}
	
	public static var ViewControllerIdentifer: String {
		return "\(Self.self)"
	}
	
	public static var ViewControllerInstance: Self {
		return UIStoryboard(name: self.StoryboardName, bundle: nil)
			.instantiateViewController(withIdentifier: self.ViewControllerIdentifer) as! Self
	}
	
}
