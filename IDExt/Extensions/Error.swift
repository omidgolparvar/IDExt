//
//  Error.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/25/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

extension Error {
	
	public func id_PrintDescription (prefixMessage: String? = nil) {
		print("⚠️ IDExt - Error: \(prefixMessage.id_IsNilOrEmpty ? "" : "\(prefixMessage!) : ") \(self.localizedDescription)")
	}
	
}
