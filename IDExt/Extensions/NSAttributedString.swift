//
//  NSAttributedString.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/5/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

public extension NSAttributedString {
	
	public static func +(lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
		let mutable = NSMutableAttributedString(attributedString: lhs)
		mutable.append(rhs)
		return mutable
	}
	
	public static func +(lhs: NSAttributedString, rhs: String) -> NSAttributedString {
		let attribuetes = lhs.attributes(at: 0, effectiveRange: nil)
		return lhs + rhs.id_MutableAttributedString(with: attribuetes)
	}
	
	public static func +(lhs: String, rhs: NSAttributedString) -> NSAttributedString {
		let attribuetes = rhs.attributes(at: 0, effectiveRange: nil)
		return lhs.id_MutableAttributedString(with: attribuetes) + rhs
	}
	
}
