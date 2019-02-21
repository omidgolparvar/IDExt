//
//  IDRouter+Models.swift
//  IDExt
//
//  Created by Omid Golparvar on 2/18/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit

public extension IDRouter {
	
	public enum RoutingType {
		case push(animated: Bool)
		case modal(animated: Bool, transitionStyle: UIModalTransitionStyle, presentationStyle: UIModalPresentationStyle)
		case storky(delegate: IDStorkyPresenterDelegate)
		case entryKit(attributes: IDPresenter.Attributes)
		
	}
	
}
