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
		let deviceFamily = UIDevice.current.dc.deviceFamily
		switch deviceFamily {
		case .iPad		: return iPadValue
		case .iPhone	: return iPhoneValue
		case .simulator where DefaultDeviceType == .iPhone	: return iPhoneValue
		case .simulator where DefaultDeviceType == .iPad	: return iPadValue
		default			: return iPhoneValue
		}
	}
	
}
