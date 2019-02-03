//
//  UISearchBar.swift
//  IDExt
//
//  Created by Omid Golparvar on 2/2/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit

public extension UISearchBar {
	
	public func id_SetupSearchBarTextField(_ closure: (UITextField) -> Void) {
		guard let textField = self.value(forKey: "searchField") as? UITextField else { return }
		closure(textField)
	}
	
}
