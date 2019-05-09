//
//  Equatable.swift
//  IDExt
//
//  Created by Omid Golparvar on 4/4/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

public extension Equatable {
	
	public func id_IsAny(of candidates: Self...) -> Bool {
		return candidates.contains(self)
	}
	
}
