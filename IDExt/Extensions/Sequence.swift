//
//  Sequence.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/14/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

public extension Sequence {
	
	public func id_Sorted <T: Comparable> (by keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
		return sorted { a, b in
			if ascending {
				return a[keyPath: keyPath] <= b[keyPath: keyPath]
			} else {
				return a[keyPath: keyPath] > b[keyPath: keyPath]
			}
		}
	}
	
	public func id_Grouped <T: Hashable> (by keyPath: KeyPath<Element, T>) -> [T: [Element]] {
		return .init(grouping: self, by: { $0[keyPath: keyPath] })
	}
}
