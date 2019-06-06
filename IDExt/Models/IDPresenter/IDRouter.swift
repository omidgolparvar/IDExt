//
//  IDRouter.swift
//  IDExt
//
//  Created by Omid Golparvar on 2/18/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit

public final class IDRouter {
	
	public static func Present(source: UIViewController, destination: UIViewController, type: RoutingType) {
		switch type {
		case .push:
			Present_Push(source, destination)
		case .modal(let transitionStyle, let presentationStyle):
			Present_Modal(source, destination, transitionStyle, presentationStyle)
		case .entryKit(let attributes):
			Present_EntryKit(destination, attributes)
		case .storky(let delegate):
			Present_Storky(source, destination, delegate)
		}
	}
	
	internal static func Present_Push(
		_ source		: UIViewController,
		_ destination	: UIViewController
		) {
		
		guard let navigationController = source.navigationController else { return }
		navigationController.pushViewController(destination, animated: true)
	}
	
	internal static func Present_Modal(
		_ source			: UIViewController,
		_ destination		: UIViewController,
		_ transitionStyle	: UIModalTransitionStyle,
		_ presentationStyle	: UIModalPresentationStyle
		) {
		
		destination.modalTransitionStyle = transitionStyle
		destination.modalPresentationStyle = presentationStyle
		source.present(destination, animated: true, completion: nil)
	}
	
	internal static func Present_EntryKit(
		_ destination	: UIViewController,
		_ attributes	: IDPresenter.Attributes
		) {
		IDPresenter.DisplayViewController(destination, using: attributes)
	}
	
	internal static func Present_Storky(
		_ source		: UIViewController,
		_ destination	: UIViewController,
		_ delegate		: IDStorkyPresenterDelegate
		) {
		IDPresenter.DisplayStorky(source, destination: destination, delegate: delegate)
	}
	
}


