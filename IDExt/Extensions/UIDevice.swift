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
	
	public static func ID_GetValueBasedOnDeviceType<T>(iPhoneValue: T, iPadValue: T) -> T {
		let currentDevice_defaultDevice = (UIDevice.current.dc.deviceFamily, ID_DefaultDeviceType)
		switch currentDevice_defaultDevice {
		case (.iPad, _)				: return iPadValue
		case (.iPhone, _)			: return iPhoneValue
		case (.simulator, .iPhone)	: return iPhoneValue
		case (.simulator, .iPad)	: return iPadValue
		default						: return iPhoneValue
		}
	}
	
}
