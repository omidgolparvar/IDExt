//
//  UIBarButtonItem.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/20/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIBarButtonItem {
	
	public static func ID_SetTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any], for state: UIControl.State = .normal) {
		UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: state)
	}
	
	public static func ID_SetupAppearance(font: UIFont, normalTextColor: UIColor, highlightedTextColor: UIColor) {
		let noramlAttributes		: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: normalTextColor]
		let highlightedAttributes	: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: highlightedTextColor]
		UIBarButtonItem.appearance().setTitleTextAttributes(noramlAttributes, for: .normal)
		UIBarButtonItem.appearance().setTitleTextAttributes(highlightedAttributes, for: .highlighted)
		
	}
	
	
	public func id_SetupTitleAttributes(font: UIFont, textColor: UIColor? = nil, for state: UIControl.State) {
		var attributes: [NSAttributedString.Key: Any] = [:]
		attributes[.font] = font
		if let color = textColor {
			attributes[.foregroundColor] = color
		}
		self.setTitleTextAttributes(attributes, for: state)
	}
	
	
	private var _id_BadgeLayer: CAShapeLayer? {
		guard let b = objc_getAssociatedObject(self, &_id_handle) as AnyObject? else { return nil }
		return b as? CAShapeLayer
	}
	
	public var id_View: UIView? {
		let view = self.value(forKey: "view") as? UIView
		return view
	}
	
	public func id_SetBadge(
		_ text: String?,
		offsetFromTopRight	: CGPoint	= .init(x: 0, y: 4),
		fillColor			: UIColor	= .red,
		textColor			: UIColor	= .white,
		font				: UIFont	= .systemFont(ofSize: 11, weight: .regular),
		padding				: CGSize	= .init(width: 2, height: 6)
		) {
		_id_BadgeLayer?.removeFromSuperlayer()
		guard let text = text, !text.isEmpty else { return }
		_id_AddBadge(text, offset: offsetFromTopRight, fillColor: fillColor, textColor: textColor, font: font, padding: padding)
	}
	
	public func id_UpdateBadge(_ text: String) {
		if let text = self._id_BadgeLayer?.sublayers?.first(where: { $0 is CATextLayer}) as? CATextLayer {
			text.string = text
		}
	}
	
	public func id_RemoveBadge() {
		_id_BadgeLayer?.removeFromSuperlayer()
	}
	
	internal func _id_AddBadge(_ text: String, offset: CGPoint, fillColor: UIColor, textColor: UIColor, font: UIFont, padding: CGSize) {
		guard let view = self.id_View else { return }
		
		let badgeSize = text.size(withAttributes: [.font: font])
		let badge = CAShapeLayer()
		
		let height	= badgeSize.height + padding.height
		var width	= badgeSize.width + padding.width
		
		if (width < height) {
			width = height
		}
		
		let x = view.frame.width - width + offset.x
		let badgeFrame = CGRect(origin: CGPoint(x: x, y: offset.y), size: CGSize(width: width, height: height))
		
		badge.id_DrawRoundedRect(rect: badgeFrame, fillColor: fillColor)
		view.layer.addSublayer(badge)
		
		let label = BarButtonBadgeTextLayer()
		label.string = text
		label.alignmentMode = .center
		label.font = font
		label.fontSize = font.pointSize
		label.frame = badgeFrame
		label.foregroundColor = fillColor.cgColor
		label.backgroundColor = UIColor.clear.cgColor
		label.contentsScale = UIScreen.main.scale
		badge.addSublayer(label)
		
		objc_setAssociatedObject(self, &_id_handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		
		badge.zPosition = 1000
	}
	
}

internal var _id_handle: UInt8 = 0;

internal class BarButtonBadgeTextLayer : CATextLayer {
	
	override init() {
		super.init()
	}
	
	override init(layer: Any) {
		super.init(layer: layer)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(layer: aDecoder)
	}
	
	override func draw(in ctx: CGContext) {
		let height = self.bounds.size.height
		let fontSize = self.fontSize
		let yDiff = (height-fontSize)/2 - fontSize/10
		
		ctx.saveGState()
		ctx.translateBy(x: 0.0, y: yDiff)
		super.draw(in: ctx)
		ctx.restoreGState()
	}
}

