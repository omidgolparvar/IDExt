//
//  UserDefaults.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

extension UserDefaults {
	
	public func id_Store(_ value: Any?, forKey key: String) {
		self.set(value, forKey: key)
		self.synchronize()
	}
	
}
