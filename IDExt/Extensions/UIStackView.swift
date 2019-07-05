//
//  UIStackView.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIStackView {
	
	public func id_RemoveAllArrangedSubviews() {
		self.subviews.forEach {
			$0.removeFromSuperview()
		}
	}
	
}
