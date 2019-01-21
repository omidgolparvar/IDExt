//
//  UIStoryboardSegue.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/19/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIStoryboardSegue {
	
	public func id_PrepareForIdentifier(_ identifier: String, perform closure: () -> Void) {
		guard let _identifier = self.identifier, _identifier == identifier else { return }
		closure()
	}
	
}
