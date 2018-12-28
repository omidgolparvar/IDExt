//
//  Optional.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/24/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension Optional {
	
	public func id_CheckAndUse(_ closure: (Wrapped) -> Void) {
		guard let _self = self else { return }
		closure(_self)
	}
	
	public func id_UnwrapOrThrow(_ error: Error) throws -> Wrapped {
		guard let value = self else { throw error }
		return value
	}
	
	public func id_Matching(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
		guard let value = self else { return nil }
		guard predicate(value) else { return nil }
		return value
	}
	
}

public extension Optional where Wrapped: Collection {
	
	public var id_IsNilOrEmpty: Bool {
		return self?.isEmpty ?? true
	}
	
}
