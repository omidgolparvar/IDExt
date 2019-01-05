//
//  String.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension String {
	
	private static let ID_EmailRegEx		= "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
	private static let ID_NumberRegEx		= "^[0-9]+?$"
	private static let ID_AlphaRegEx		= "^[A-Za-z]+$"
	private static let ID_AlphaNumericRegEx	= "^[A-Za-z0-9]+$"
	
	public var id_IsEmail: Bool {
		return id_Match(regex: String.ID_EmailRegEx)
	}
	
	public var id_IsNumber: Bool {
		return id_Match(regex: String.ID_NumberRegEx)
	}
	
	public var id_IsAlpha: Bool {
		return id_Match(regex: String.ID_AlphaRegEx)
	}
	
	public var id_IsAlphaNumeric: Bool {
		return id_Match(regex: String.ID_AlphaNumericRegEx)
	}
	
	public var id_Trimmed: String {
		return self.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	public var id_Base64Encoded: String {
		return Data(self.utf8).base64EncodedString()
	}
	
	public var id_Base64Decoded: String? {
		guard let data = Data(base64Encoded: self) else { return nil }
		return String(data: data, encoding: .utf8)
	}
	
	public var id_AttributedString: NSAttributedString {
		return NSAttributedString(string: self)
	}
	
	public var id_MutableAttributedString: NSMutableAttributedString {
		return NSMutableAttributedString(string: self)
	}
	
	public var id_AsURL: URL? {
		return URL(string: self)
	}
	
	public var id_Range: NSRange {
		return NSRange(location: 0, length: count)
	}
	
	
	public mutating func id_ReplaceFirstOccurrence(ofString target: String, withString replaceString: String) {
		if let range = self.range(of: target) {
			self = self.replacingCharacters(in: range, with: replaceString)
		}
	}
	
	public func id_ReplacedFirstOccurrence(of target: String, with replaceString: String) -> String {
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
	
	public func id_GenerateQRCodeImage(scale: CGFloat = 2) -> UIImage? {
		return UIImage.ID_Initialize(generateQRCodeFromString: self, scale: scale)
	}
	
	public func id_Indices(of string: String) -> [Int] {
		var indices: [Int] = []
		var searchStartIndex = self.startIndex
		
		while
			searchStartIndex < self.endIndex,
			let range = self.range(of: string, range: searchStartIndex..<self.endIndex), !range.isEmpty {
			let index = distance(from: self.startIndex, to: range.lowerBound)
			indices.append(index)
			searchStartIndex = range.upperBound
		}
		
		return indices
	}
	
	public func id_Character(at position: Int) -> String? {
		guard 0..<count ~= position else { return nil }
		return String(self[index(startIndex, offsetBy: position)])
	}
	
	public func id_Substring(in range: CountableRange<Int>) -> String? {
		guard
			let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex),
			let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex)
			else { return nil }
		return String(self[lowerIndex..<upperIndex])
	}
	
	public func id_Substring(in range: ClosedRange<Int>) -> String? {
		guard
			let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex),
			let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex)
			else { return nil }
		return String(self[lowerIndex..<upperIndex])
	}
	
	public func id_Substring(in range: CountablePartialRangeFrom<Int>) -> String? {
		guard
			let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex)
			else { return nil }
		return String(self[lowerIndex..<endIndex])
	}
	
	public func id_Truncated(_ length: Int, trailing: String = "...") -> String {
		guard 1..<count ~= length else { return self }
		return prefix(length) + trailing
	}
	
	public func id_Match(regex pattern: String) -> Bool {
		let options: CompareOptions = [.regularExpression]
		return range(of: pattern, options: options) != nil
	}
	
	public mutating func id_RemoveNonNumbericCharacters() {
		self = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
	}
	
	public func id_MutableAttributedString(with attributes: [NSAttributedString.Key: Any], range: NSRange? = nil) -> NSMutableAttributedString {
		let mutable = id_MutableAttributedString
		mutable.addAttributes(attributes, range: range ?? self.id_Range)
		return mutable
	}
	
}
