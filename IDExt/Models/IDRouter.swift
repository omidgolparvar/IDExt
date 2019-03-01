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
		case .push(let animated):
			Present_Push(source, destination, animated)
		case .modal(let isEmbeddedInNavigationController, let animated, let transitionStyle, let presentationStyle):
			Present_Modal(source, destination, isEmbeddedInNavigationController, animated, transitionStyle, presentationStyle)
		case .entryKit(let attributes):
			Present_EntryKit(destination, attributes)
		case .storky(let delegate):
			Present_Storky(source, destination, delegate)
		}
	}
	
	internal static func Present_Push(
		_ source		: UIViewController,
		_ destination	: UIViewController,
		_ animated		: Bool
		) {
		guard let navigationController = source.navigationController else { return }
		navigationController.pushViewController(destination, animated: animated)
	}
	
	internal static func Present_Modal(
		_ source							: UIViewController,
		_ destination						: UIViewController,
		_ isEmbeddedInNavigationController	: Bool,
		_ animated							: Bool,
		_ transitionStyle					: UIModalTransitionStyle,
		_ presentationStyle					: UIModalPresentationStyle
		) {
		
		var finalDestinationController: UIViewController
		if isEmbeddedInNavigationController {
			let navigationController = UINavigationController(rootViewController: destination)
			let dismissBarButton = UIBarButtonItem(title: "بازگشت", style: .done, target: destination, action: #selector(destination.id_Dismiss))
			destination.navigationItem.rightBarButtonItem = dismissBarButton
			finalDestinationController = navigationController
		} else {
			finalDestinationController = destination
		}
		
		finalDestinationController.modalTransitionStyle = transitionStyle
		finalDestinationController.modalPresentationStyle = presentationStyle
		source.present(finalDestinationController, animated: animated, completion: nil)
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


