//
//  IDHighlightableCollectionViewCell.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDHighlightableCollectionViewCell {
	
	var highlightBackgroundColor	: UIColor { get }
	
	var originalBackgroundColor		: UIColor { get }
	
}
