//
//  IDLayouta.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public final class IDLayouta {
	
	private var current		: Int = 1
	private var required	: Int
	private var isDone		: Bool = false
	
	public init(required: Int) {
		self.required = required
	}
	
	public func checkAndPerform(_ callback: () -> Void) {
		guard !isDone, current == required else {
			current += 1
			return
		}
		
		callback()
		isDone = true
	}
	
}
