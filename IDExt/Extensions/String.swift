//
//  String.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension String {
	
	public static func ID_Text(bundle: Bundle = .main, fileName: String = "Texts", keyName: String) -> String? {
		guard
			let filePath	= bundle.path(forResource: fileName, ofType: "plist"),
			let dictionary	= NSDictionary(contentsOfFile: filePath),
			let valueForKey	= dictionary.object(forKey: keyName) as? String
			else { return nil }
		return valueForKey
	}
	
	private static let ID_EmailRegEx		= "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
	private static let ID_NumberRegEx		= "^[0-9]+?$"
	private static let ID_AlphaRegEx		= "^[A-Za-z]+$"
	private static let ID_AlphaNumericRegEx	= "^[A-Za-z0-9]+$"
	
	public var id_IsEmail: Bool {
		return id_IsMatching(regex: String.ID_EmailRegEx)
	}
	
	public var id_IsNumeric: Bool {
		return id_IsMatching(regex: String.ID_NumberRegEx)
	}
	
	public var id_IsAlphabetic: Bool {
		return id_IsMatching(regex: String.ID_AlphaRegEx)
	}
	
	public var id_IsAlphaNumeric: Bool {
		return id_IsMatching(regex: String.ID_AlphaNumericRegEx)
	}
	
	public var id_Trimmed: String {
		return self.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	public var id_Base64Encoded: String? {
		return self.data(using: .utf8)?.base64EncodedString()
	}
	
	public var id_Base64Decoded: String? {
		guard let data = Data(base64Encoded: self) else { return nil }
		return String(data: data, encoding: .utf8)
	}
	
	public var id_AsURL: URL? {
		return URL(string: self.id_Trimmed)
	}
	
	public var id_Range: NSRange {
		return NSRange(location: 0, length: count)
	}
	
	public var id_StringWithoutNonDigits: String {
		return self.ps.withEasternDigits.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
	}
	
	public var id_IntValue: Int? {
		return Int(self.id_StringWithoutNonDigits)
	}
	
	public var id_AsColor: UIColor {
		return UIColor.ID_Initialize(hexCode: self)
	}
	
	public mutating func id_ReplaceFirstOccurrence(of target: String, with replaceString: String) {
		if let range = self.range(of: target) {
			self = self.replacingCharacters(in: range, with: replaceString)
		}
	}
	
	public func id_ReplacedFirstOccurrence(of target: String, with replaceString: String) -> String {
		var temp = self
		temp.id_ReplaceFirstOccurrence(of: target, with: replaceString)
		return temp
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
	
	public func id_GenerateQRCodeImage(scale: CGFloat = 2) -> UIImage? {
		return UIImage.ID_Initialize(generateQRCodeFromString: self, scale: scale)
	}
	
	public func id_Indices(of string: String) -> [Int] {
		var indices: [Int] = []
		var searchStartIndex = self.startIndex
		
		while	searchStartIndex < self.endIndex,
				let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
				!range.isEmpty {
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
	
	public func id_IsMatching(regex pattern: String) -> Bool {
		return range(of: pattern, options: [.regularExpression]) != nil
	}
	
	public mutating func id_AddStartPadding(finalLenght: Int, character: Character = " ") {
		var result = self
		guard finalLenght > self.count else { return }
		for _ in 0..<(finalLenght - self.count) {
			result = String(character) + result
		}
		self = result
	}
	
	public mutating func id_AddEndPadding(finalLenght: Int, character: Character = " ") {
		var result = self
		guard finalLenght > self.count else { return }
		for _ in 0..<(finalLenght - self.count) {
			result = result + String(character)
		}
		self = result
	}
	
	public mutating func id_ConvertToCorrectMobileNumber() {
		var mobile = self.ps.withEasternDigits.replacingOccurrences(of: "[^0-9+]", with: "", options: .regularExpression)
		
		if mobile.hasPrefix("00989") {
			mobile = mobile.id_ReplacedFirstOccurrence(of: "00989", with: "09")
		} else if mobile.hasPrefix("+989") {
			mobile = mobile.id_ReplacedFirstOccurrence(of: "+989", with: "09")
		} else if mobile.hasPrefix("989") {
			mobile = mobile.id_ReplacedFirstOccurrence(of: "989", with: "09")
		}
		
		self = mobile
	}
	
	public func id_StringByPrefix(_ maxLength: Int) -> String {
		return String(self.prefix(maxLength))
	}
	
	public mutating func id_ConvertToHTTPURLString(with schema: String = "http") {
		if !self.lowercased().hasPrefix(schema + "://") {
			self = schema + "://" + self
		}
	}
	
	public var id_IsRTL: Bool {
		let cleanFile = self.replacingOccurrences(of: "\r", with: "\n")
		var newLineIndices: [Int] = []
		
		for (index, char) in cleanFile.enumerated() {
			if char == "\n" {
				newLineIndices.append(index)
			}
		}
		
		newLineIndices.insert(-1, at: 0)
		newLineIndices.append(cleanFile.count)
		
		let tagschemes = NSArray(objects: NSLinguisticTagScheme.language)
		let tagger = NSLinguisticTagger(tagSchemes: tagschemes as! [NSLinguisticTagScheme], options: 0)
		tagger.string = cleanFile
		
		for i in 0..<newLineIndices.count - 1 {
			let language = tagger.tag(
				at				: newLineIndices[i + 1] - 1,
				scheme			: NSLinguisticTagScheme.language,
				tokenRange		: nil,
				sentenceRange	: nil
			)
			
			if	String(describing: language).range(of: "he") != nil ||
				String(describing: language).range(of: "ar") != nil ||
				String(describing: language).range(of: "fa") != nil {
				return true
			} else {
				return false
			}
		}
		
		return false
	}
	
	
	
	public subscript(i: Int) -> String {
		return String(self[index(startIndex, offsetBy: i)])
	}
	
	public subscript(bounds: CountableRange<Int>) -> String {
		let start = index(startIndex, offsetBy: bounds.lowerBound)
		let end = index(startIndex, offsetBy: bounds.upperBound)
		return String(self[start ..< end])
	}
	
	public subscript(bounds: CountableClosedRange<Int>) -> String {
		let start = index(startIndex, offsetBy: bounds.lowerBound)
		let end = index(startIndex, offsetBy: bounds.upperBound)
		return String(self[start ... end])
	}
	
	public subscript(bounds: CountablePartialRangeFrom<Int>) -> String {
		let start = index(startIndex, offsetBy: bounds.lowerBound)
		let end = index(endIndex, offsetBy: -1)
		return String(self[start ... end])
	}
	
	public subscript(bounds: PartialRangeThrough<Int>) -> String {
		let end = index(startIndex, offsetBy: bounds.upperBound)
		return String(self[startIndex ... end])
	}
	
	public subscript(bounds: PartialRangeUpTo<Int>) -> String {
		let end = index(startIndex, offsetBy: bounds.upperBound)
		return String(self[startIndex ..< end])
	}
	
}

