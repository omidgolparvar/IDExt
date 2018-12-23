//
//  Dictionary.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/23/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension Dictionary where Key == String {
	
	public var id_AsJSONString: String {
		return id_AsJSONString(withOptions: [])
	}
	
	public func id_AsJSONString(withOptions options: JSONSerialization.WritingOptions = []) -> String {
		let jsonData = try! JSONSerialization.data(withJSONObject: self, options: options)
		let jsonString = String(data: jsonData, encoding: .utf8)!
		return jsonString
	}
	
}
