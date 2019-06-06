//
//  IndexPath.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/11/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension IndexPath {
	
	public static func ID_First(in section: Int = 0) -> IndexPath {
		return IndexPath(row: 0, section: section)
	}
	
}
