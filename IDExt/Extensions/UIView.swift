//
//  UIView.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIView {
	
	public func id_Shake(duration: Double = 0.6, shakePattern: [Double] = [-16.0, 16.0, -16.0, 16.0, -8.0, 8.0, -5.0, 5.0, 0.0]) {
		let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		animation.duration = duration
		animation.values = shakePattern
		self.layer.add(animation, forKey: "shake")
	}
	
	public func id_SetCornerRadius(_ cornerRadius: CGFloat) {
		self.layer.cornerRadius = cornerRadius
		self.clipsToBounds = true
	}
	
	public func id_RoundCorners() {
		if self.frame.width >= self.frame.height {
			self.id_SetCornerRadius(self.frame.height / 2.0)
		} else {
			self.id_SetCornerRadius(self.frame.width / 2.0)
		}
	}
	
	public func id_SetRadiusForCorners(radius: CGFloat, corners: UIRectCorner) {
		let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		self.layer.mask = mask
	}
	
	public func id_SetRoundedShadow(cornerRadius: CGFloat, fillColor: UIColor, shadowColor: UIColor, shadowOpacity: Float, shadowRadius: CGFloat, shadowOffset: CGSize) {
		let shadowLayer = CAShapeLayer()
		shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
		shadowLayer.fillColor = fillColor.cgColor
		shadowLayer.shadowColor = shadowColor.cgColor
		shadowLayer.shadowPath = shadowLayer.path
		shadowLayer.shadowOffset = shadowOffset
		shadowLayer.shadowOpacity = shadowOpacity
		shadowLayer.shadowRadius = shadowRadius
		self.layer.cornerRadius = cornerRadius
		self.layer.insertSublayer(shadowLayer, at: 0)
	}
	
	public func id_SetupShadow(color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) {
		self.layer.shadowColor		= color.cgColor
		self.layer.shadowOffset		= offset
		self.layer.shadowRadius		= radius
		self.layer.shadowOpacity	= opacity
	}
	
	public enum IDBorderStyle {
		case none
		case border(color: UIColor, width: CGFloat)
	}
	public func id_SetBorder(style: IDBorderStyle) {
		switch style {
		case .none:
			self.layer.borderColor = nil
			self.layer.borderWidth = 0
		case .border(let color, let width):
			self.layer.borderColor = color.cgColor
			self.layer.borderWidth = width
		}
	}
	
}

