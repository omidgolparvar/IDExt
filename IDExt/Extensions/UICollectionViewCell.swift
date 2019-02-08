//
//  UICollectionViewCell.swift
//  IDExt
//
//  Created by Omid Golparvar on 2/8/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionViewCell {
	
	public func id_ModifyBackgroundColor(isHighlighted: Bool) {
		guard let cell = self as? IDHighlightableCollectionViewCell else { return }
		
		var highlightView: UIView
		if let tag = cell.highlightViewTag, let view = self.viewWithTag(tag) {
			highlightView = view
		} else {
			highlightView = self
		}
		
		UIView.animate(withDuration: 0.2) {
			highlightView.backgroundColor = isHighlighted ? cell.highlightBackgroundColor : cell.originalBackgroundColor
		}
	}
	
}
