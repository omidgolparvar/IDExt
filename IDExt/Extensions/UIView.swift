//
//  UIView.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIView {
	
	public static func ID_Animate(_ animation: @autoclosure @escaping () -> Void, duration: TimeInterval = 0.25) {
		UIView.animate(withDuration: duration, animations: animation)
	}
	
	public static var ID_WithZeroFrame: UIView {
		return UIView(frame: .zero)
	}
	
	public func id_Shake() {
		let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		animation.duration = 0.6
		animation.values = [-16.0, 16.0, -16.0, 16.0, -8.0, 8.0, -5.0, 5.0, 0.0]
		self.layer.add(animation, forKey: "shake")
	}
	
	public func id_SetCornerRadius(_ cornerRadius: CGFloat) {
		self.layer.cornerRadius = cornerRadius
		self.clipsToBounds = true
	}
	
	public func id_RoundCorners() {
		self.id_SetCornerRadius(self.frame.height / 2.0)
	}
	
	public func id_SetRadiusForCorners(radius: CGFloat, corners: UIRectCorner) {
		let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		self.layer.mask = mask
	}
	
	public func id_DisableUserInteraction() {
		self.isUserInteractionEnabled = false
	}
	
	public func id_EnableUserInteraction() {
		self.isUserInteractionEnabled = true
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
	
	public func id_SetBorder(color: UIColor?, width: CGFloat) {
		self.layer.borderColor = color?.cgColor
		self.layer.borderWidth = width
	}
	
	public func id_SetTransform(rotationAngle: CGFloat) {
		self.transform = CGAffineTransform(rotationAngle: rotationAngle)
	}
	
	public func id_SetTransform(scaleX: CGFloat, y scaleY: CGFloat) {
		self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
	}
	
	public func id_SetTransform(translationX: CGFloat, y translationY: CGFloat) {
		self.transform = CGAffineTransform(translationX: translationX, y: translationY)
	}
	
	public func id_SetTransformToIdentity() {
		self.transform = .identity
	}
	
}

