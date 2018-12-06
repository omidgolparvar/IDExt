//
//  UIDevice.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import UIDeviceComplete

public extension UIDevice {
	
	public static var ID_DefaultDeviceType: DeviceFamily = .iPhone
	
	public func id_ValueBasedOnDeviceType<T>(iPhone iPhoneValue: T, iPad iPadValue: T) -> T {
		let deviceFamily = UIDevice.current.dc.deviceFamily
		switch deviceFamily {
		case .iPad		: return iPadValue
		case .iPhone	: return iPhoneValue
		case .simulator where UIDevice.ID_DefaultDeviceType == .iPhone	: return iPhoneValue
		case .simulator where UIDevice.ID_DefaultDeviceType == .iPad	: return iPadValue
		default			: return iPhoneValue
		}
	}
	
}
