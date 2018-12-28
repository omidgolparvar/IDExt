//
//  URL.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/26/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension URL {
	
	public var queryParameters: [String: String]? {
		guard
			let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
			let queryItems = components.queryItems
			else { return nil }
		var items: [String: String] = [:]
		for queryItem in queryItems {
			items[queryItem.name] = queryItem.value
		}
		return items
	}
	
}
