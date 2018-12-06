//
//  IDOther.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/7/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public final class IDOther {
	
	public static func SetupAutolayoutMessages(isEnable: Bool) {
		UserDefaults.standard.id_Store(isEnable ? nil : false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
	}
	
}
