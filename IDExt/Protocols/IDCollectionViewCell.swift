//
//  IDCollectionViewCell.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDCollectionViewCell where Self: UICollectionViewCell {
	
	static var Identifier	: String { get }
	
	var cellSize			: CGSize { get }
	
}
