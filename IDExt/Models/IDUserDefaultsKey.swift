//
//  IDUserDefaultsKey.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/5/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

open class IDUserDefaultsKeys {
	
	public static let UserName = IDUserDefaultsKey<String?>("username")
	
	init() {}
}

open class IDUserDefaultsKey<ValueType>: IDUserDefaultsKeys {
	public let name: String
	
	public init(_ key: String) {
		self.name = key
		super.init()
	}
}


