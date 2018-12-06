//
//  NSError.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/26/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension NSError {
	
	var id_ErrorStyleDescription: String {
		return String(format: "Domain: %@ - Code: %@ - Description: %@", self.domain, self.code, self.description)
	}
	
}
