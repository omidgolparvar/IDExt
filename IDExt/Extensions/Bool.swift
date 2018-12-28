//
//  Bool.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/18/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension Bool {
	
	public func id_IfIsTrue(_ block: () -> Void) {
		guard self else { return }
		block()
	}
	
	public func id_CheckAndPerform(ifTrue closure_True: @autoclosure () -> Void, ifFalse closure_False: @autoclosure () -> Void) {
		if self { closure_True() }
		else { closure_False() }
	}
	
}
