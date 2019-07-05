//
//  IDVisualEffectView.swift
//  IDExt
//
//  Created by Omid Golparvar on 2/8/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit

/* Original: https://github.com/efremidze/VisualEffectView */

open class IDVisualEffectView: UIVisualEffectView {
	
	private let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()
	
	open var colorTint: UIColor? {
		get { return _value(forKey: "colorTint") as? UIColor }
		set { _setValue(newValue, forKey: "colorTint") }
	}
	
	open var colorTintAlpha: CGFloat {
		get { return _value(forKey: "colorTintAlpha") as! CGFloat }
		set { _setValue(newValue, forKey: "colorTintAlpha") }
	}
	
	open var blurRadius: CGFloat {
		get { return _value(forKey: "blurRadius") as! CGFloat }
		set { _setValue(newValue, forKey: "blurRadius") }
	}
	
	/**
	Scale factor.
	
	The scale factor determines how content in the view is mapped from the logical coordinate space (measured in points) to the device coordinate space (measured in pixels).
	
	The default value is 1.0.
	*/
	open var scale: CGFloat {
		get { return _value(forKey: "scale") as! CGFloat }
		set { _setValue(newValue, forKey: "scale") }
	}
	
	public override init(effect: UIVisualEffect?) {
		super.init(effect: effect)
		commonInit()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		scale = 1
	}
	
	private func _value(forKey key: String) -> Any? {
		return blurEffect.value(forKeyPath: key)
	}
	
	private func _setValue(_ value: Any?, forKey key: String) {
		blurEffect.setValue(value, forKeyPath: key)
		self.effect = blurEffect
	}
	
}
