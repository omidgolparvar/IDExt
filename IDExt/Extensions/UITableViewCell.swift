//
//  UITableViewCell.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UITableViewCell {
	
	public func id_ModifyBackgroundColor(isHighlighted: Bool) {
		guard let cell = self as? IDHighlightableTableViewCell else { return }
		
		let highlightView = self.viewWithTag(cell.highlightViewTag) ?? self
		
		UIView.animate(withDuration: 0.2) {
			highlightView.backgroundColor = isHighlighted ? cell.highlightBackgroundColor : cell.originalBackgroundColor
		}
	}
	
	@objc
	public dynamic var id_SelectionColor: UIColor? {
		get { return selectedBackgroundView?.backgroundColor }
		set {
			guard selectionStyle != .none else { return }
			selectedBackgroundView = UIView().id_with {
				$0.backgroundColor = newValue
			}
		}
	}
	
}
