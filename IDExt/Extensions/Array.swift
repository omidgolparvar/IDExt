//
//  Array.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/10/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension Array {
	
	public func id_SafeItem(at index: Int) -> Element? {
		guard (0..<self.count) ~= index else { return nil }
		return self[index]
	}
	
}
