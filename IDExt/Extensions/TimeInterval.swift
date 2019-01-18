//
//  TimeInterval.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/18/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

public extension TimeInterval {
	
	public func id_AfterSecondsPerform(_ closure: @escaping () -> Void) {
		DispatchQueue.main.asyncAfter(deadline: .now() + self) { closure() }
	}
	
}
