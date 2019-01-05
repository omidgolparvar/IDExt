//
//  IDWith.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/5/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDWith {}

public extension IDWith where Self: Any {
	
	@discardableResult
	func id_with(_ block: (Self) -> Void) -> Self {
		// https://github.com/devxoul/Then
		block(self)
		return self
	}
}

extension NSObject: IDWith {}
