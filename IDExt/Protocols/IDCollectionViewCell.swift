//
//  IDCollectionViewCell.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDCollectionViewCell {
	
	static var Identifier	: String { get }
	
	var cellSize			: CGSize { get }
	
}
