//
//  IDGlobal.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/4/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public func IDPrint(_ items: Any..., separator: String = ", ", terminator: String = "\n") {
	#if DEBUG
		print(items, separator: separator, terminator: terminator)
		return
	#else
		return
	#endif
}
