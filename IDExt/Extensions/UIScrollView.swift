//
//  UIScrollView.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/23/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIScrollView {
	
	public func id_AddContentInsetValues(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
		var newContentInset = self.contentInset
		newContentInset.top		+= top
		newContentInset.right	+= right
		newContentInset.bottom	+= bottom
		newContentInset.left	+= left
		self.contentInset = newContentInset
	}
	
}
