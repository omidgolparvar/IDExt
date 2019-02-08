//
//  IDStorkyPresenterDelegate.swift
//  IDExt
//
//  Created by Omid Golparvar on 2/8/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDStorkyPresenterDelegate: NSObjectProtocol {
	
	func idStorkyPresenter_IsSwipeToDismissEnabled		(for controller: UIViewController) -> Bool
	func idStorkyPresenter_isTapAroundToDismissEnabled	(for controller: UIViewController) -> Bool
	func idStorkyPresenter_ShowIndicator				(for controller: UIViewController) -> Bool
	func idStorkyPresenter_IndicatorColor				(for controller: UIViewController) -> UIColor
	func idStorkyPresenter_CustomHeight					(for controller: UIViewController) -> CGFloat?
	
}

public extension IDStorkyPresenterDelegate {
	
	public func idStorkyPresenter_IsSwipeToDismissEnabled		(for controller: UIViewController) -> Bool {
		return true
	}
	
	public func idStorkyPresenter_isTapAroundToDismissEnabled	(for controller: UIViewController) -> Bool {
		return true
	}
	
	public func idStorkyPresenter_ShowIndicator					(for controller: UIViewController) -> Bool {
		return true
	}
	
	public func idStorkyPresenter_IndicatorColor				(for controller: UIViewController) -> UIColor {
		return .init(red: 202/255, green: 201/255, blue: 207/255, alpha: 1)
	}
	
	public func idStorkyPresenter_CustomHeight					(for controller: UIViewController) -> CGFloat? {
		return nil
	}
	
}


