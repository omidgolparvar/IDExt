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

infix operator ???
public func ??? (condition: Bool, closures: (onTrue: () -> Void, onFalse: () -> Void)) {
	if condition {
		closures.onTrue()
	} else {
		closures.onFalse()
	}
}

infix operator ???+
public func ???+ (condition: Bool, closure: @autoclosure () -> Void) {
	guard condition else { return }
	closure()
}

infix operator ???-
public func ???- (condition: Bool, closure: @autoclosure () -> Void) {
	guard !condition else { return }
	closure()
}

infix operator <->
public func <-> (dates: (from: Date, to: Date), components: Set<Calendar.Component>) -> DateComponents {
	let dateComponents = Calendar.current.dateComponents(components, from: dates.from, to: dates.to)
	return dateComponents
}


