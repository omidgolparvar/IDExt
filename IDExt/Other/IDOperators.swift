//

import Foundation

prefix operator >>>
public prefix func >>> (item: Any) {
	#if DEBUG
		print(item)
		return
	#else
		return
	#endif
}


prefix operator <?>
public prefix func <?> <T: IDType>(lhs: T) -> T.Type {
	return lhs._Type_
}


infix operator |||
public func ||| (delay: TimeInterval, closure: @autoclosure @escaping () -> Void) {
	DispatchQueue.main.asyncAfter(deadline: .now() + delay) { closure() }
}


precedencegroup BooleanHandlerPrecedence {
	lowerThan: ComparisonPrecedence
}
infix operator ?+ : BooleanHandlerPrecedence
public func ?+ (condition: Bool, closure: @autoclosure () -> Void) {
	guard condition else { return }
	closure()
}

infix operator ?- : BooleanHandlerPrecedence
public func ?- (condition: Bool, closure: @autoclosure () -> Void) {
	guard !condition else { return }
	closure()
}






