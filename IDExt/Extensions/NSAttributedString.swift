//
//  NSAttributedString.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/5/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

public extension NSAttributedString {
	
	public static func +(lhs: NSAttributedString, rhs: NSAttributedString) -> NSMutableAttributedString {
		let mutable = NSMutableAttributedString(attributedString: lhs)
		mutable.append(rhs)
		return mutable
	}
	
	public static func +(lhs: NSAttributedString, rhs: String) -> NSMutableAttributedString {
		return lhs + rhs.id_AttributedString
	}
}
