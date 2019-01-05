//
//  UserDefaults.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UserDefaults {
	
	public func id_Store(_ value: Any?, forKey key: String) {
		set(value, forKey: key)
		synchronize()
	}
	
	public func id_Get<T>(_ key: IDUserDefaultsKey<T?>) -> T? {
		return self.object(forKey: key.name) as? T
	}
	
	public func id_Set<T>(_ value: T?, forKey key: IDUserDefaultsKey<T?>) {
		guard let newValue = value else {
			removeObject(forKey: key.name)
			synchronize()
			return
		}
		set(newValue, forKey: key.name)
		synchronize()
	}
	
	public func id_Remove<T>(_ key: IDUserDefaultsKey<T?>) {
		removeObject(forKey: key.name)
		synchronize()
	}
	
}
