//
//  UILabel.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/11/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UILabel {
	
	public var id_RequiredNumberOfLines: Int {
		// Call self.layoutIfNeeded() if your view is uses auto layout
		self.layoutIfNeeded()
		let myText = self.text! as NSString
		let attributes: [NSAttributedString.Key: Any] = [.font : self.font]
		let labelSize = myText.boundingRect(
			with		: CGSize(width: self.bounds.width, height: .greatestFiniteMagnitude),
			options		: .usesLineFragmentOrigin,
			attributes	: attributes,
			context		: nil
		)
		return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
	}
	
	public var id_IsTruncated: Bool {
		return self.id_RequiredNumberOfLines > self.numberOfLines
	}
	
	
}
