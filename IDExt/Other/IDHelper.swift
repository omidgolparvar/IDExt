//
//  IDHelper.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/10/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import UIDeviceComplete

public final class IDHelper {
	
	public static func DebugPrint(_ items: Any..., separator: String = ", ", terminator: String = "\n") {
		#if DEBUG
			print(items, separator: separator, terminator: terminator)
			return
		#else
			return
		#endif
	}
	
	public static func SetupAutolayoutMessages(isEnable: Bool) {
		UserDefaults.standard.id_Store(isEnable ? nil : false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
	}
	
	
}
