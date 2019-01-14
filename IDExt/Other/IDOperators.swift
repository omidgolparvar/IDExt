//
//  IDOperators.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/8/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

prefix operator >>>
public prefix func >>> (item: Any) {
	IDHelper.DebugPrint(item)
}

prefix operator <?>
public prefix func <?> <T: IDType>(lhs: T) -> T.Type {
	return lhs.__Type
}

infix operator |||
public func ||| (delay: TimeInterval, closure: @autoclosure @escaping () -> Void) {
	DispatchQueue.main.asyncAfter(deadline: .now() + delay) { closure() }
}

