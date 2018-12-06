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
		let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
			self.removeArrangedSubview(subview)
			return allSubviews + [subview]
		}
		NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
		removedSubviews.forEach({ $0.removeFromSuperview() })
	}
	
}
