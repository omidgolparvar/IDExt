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
	
	public static func DetailedPrint(_ item: Any, file: String = #file, function: String = #function, line: Int = #line) {
		#if DEBUG
			let fileName = file.components(separatedBy: "/")
			print("""
			[\(fileName.isEmpty ? "" : fileName.last!)] : #\(line) : \(function)
			\(item)
			""")
			return
		#else
			return
		#endif
	}
	
	
	public static func SetupAutolayoutMessages(isEnabled: Bool) {
		UserDefaults.standard.set(isEnabled ? nil : false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
	}
	
	
}
