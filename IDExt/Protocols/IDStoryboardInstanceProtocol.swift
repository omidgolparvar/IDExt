//
//  IDStoryboardInstanceProtocol.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/23/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit

public protocol IDStoryboardInstanceProtocol where Self: UIViewController {
	
	static var IDStoryboardName				: String	{ get }
	static var IDViewControllerIdentifer	: String	{ get }
	static var IDStoryboardPattern			: String	{ get }
	static var IDViewControllerInstance		: Self		{ get }
	
}

public extension IDStoryboardInstanceProtocol {
	
	public static var IDStoryboardName: String {
		return "Main"
	}
	
	public static var IDViewControllerIdentifer: String {
		return "\(Self.self)"
	}
	
	public static var IDStoryboardPattern: String {
		return "\(self.IDStoryboardName)|\(self.IDViewControllerIdentifer)"
	}
	
	public static var IDViewControllerInstance: Self {
		return UIViewController.ID_Initialize(pattern: self.IDStoryboardPattern) as! Self
	}
	
}
