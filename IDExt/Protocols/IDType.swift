//
//  IDType.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/5/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDType {
	
}

public extension IDType where Self: Any {
	
	public var __Type: Self.Type {
		return type(of: self)
	}
}

extension NSObject: IDType {}


