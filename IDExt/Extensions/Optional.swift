//
//  Optional.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/24/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

extension Optional {
	
	func id_CheckAndUse(_ closure: (Wrapped) -> Void) {
		guard let _self = self else { return }
		closure(_self)
	}
	
}

extension Optional where Wrapped: Collection {
	
	public var id_IsNilOrEmpty: Bool {
		return self?.isEmpty ?? true
	}
	
}
