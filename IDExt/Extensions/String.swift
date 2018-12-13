//
//  String.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension String {
	
	public var id_Trimmed: String {
		return self.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	public mutating func id_ReplaceFirstOccurrence(ofString target: String, withString replaceString: String) {
		if let range = self.range(of: target) {
			self = self.replacingCharacters(in: range, with: replaceString)
		}
	}
	
	public func id_ReplacedFirstOccurrence(ofString target: String, withString replaceString: String) -> String {
		var temp = self
		temp.id_ReplaceFirstOccurrence(ofString: target, withString: replaceString)
		return temp
	}
	
	public func id_EmojiImage() -> UIImage? {
		let size = CGSize(width: 40, height: 40)
		UIGraphicsBeginImageContextWithOptions(size, false, 0)
		UIColor.clear.set()
		let rect = CGRect(origin: .zero, size: size)
		UIRectFill(CGRect(origin: .zero, size: size))
		(self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}
	
	public func id_RegexMatches(for regex: String) -> [String] {
		do {
			let regex = try NSRegularExpression(pattern: regex)
			let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
			return results.map { String(self[Range($0.range, in: self)!]) }
		} catch let error {
			error.id_PrintDescription(prefixMessage: "Invalis Regex.")
			return []
		}
	}
	
	public mutating func id_ReplaceAllPrefixes(_ prefixes: [String], with string: String, continueAfterFirstPerform: Bool = false) {
		for prefix in prefixes {
			if self.hasPrefix(prefix) {
				self.id_ReplaceFirstOccurrence(ofString: prefix, withString: string)
				if !continueAfterFirstPerform { return }
			}
		}
	}
	
	public func id_ReplacedAllPrefixes(_ prefixes: [String], with string: String, continueAfterFirstPerform: Bool = false) -> String {
		var temp = self
		for prefix in prefixes {
			if temp.hasPrefix(prefix) {
				temp.id_ReplaceFirstOccurrence(ofString: prefix, withString: string)
				if !continueAfterFirstPerform { return temp }
			}
		}
		return temp
	}
	
	
}
