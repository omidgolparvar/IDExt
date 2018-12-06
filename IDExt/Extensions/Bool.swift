//
//  Bool.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/18/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

extension Bool {
	
	public func id_IfIsTrue(_ block: () -> Void) {
		guard self else { return }
		block()
	}
	
}
