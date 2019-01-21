//
//  NSError.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/26/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension NSError {
	
	public var id_ErrorStyleDescription: String {
		return "Domain: \(self.domain) - Code: \(self.code) - Description: \(self.description)"
	}
	
}
