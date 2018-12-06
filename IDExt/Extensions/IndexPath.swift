//
//  IndexPath.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/11/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

extension IndexPath {
	
	public static var ID_First: IndexPath { return IndexPath(row: 0, section: 0) }
	
	public static func ID_First(inSection section: Int) -> IndexPath {
		return IndexPath(row: 0, section: section)
	}
	
}
