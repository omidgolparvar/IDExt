//
//  UISegmentedControl.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UISegmentedControl {
	
	public func id_SetFont(_ font: UIFont) {
		self.setTitleTextAttributes([.font: font], for: .normal)
	}
	
}
