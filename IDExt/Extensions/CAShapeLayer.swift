//
//  CAShapeLayer.swift
//  IDExt
//
//  Created by Omid Golparvar on 2/19/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit

public extension CAShapeLayer {
	
	func id_DrawRoundedRect(
		rect						: CGRect,
		fillColor _fillColor		: UIColor?	= nil,
		strokeColor _strokeColor	: UIColor?	= nil,
		cornerRadius _cornerRadius	: CGFloat?	= nil
		) {
		fillColor = _fillColor?.cgColor
		strokeColor = _strokeColor?.cgColor
		path = UIBezierPath(roundedRect: rect, cornerRadius: _cornerRadius ?? (rect.height / 2)).cgPath
	}
	
}
