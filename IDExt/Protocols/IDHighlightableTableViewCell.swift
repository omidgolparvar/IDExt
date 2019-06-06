//
//  IDHighlightableTableViewCell.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDHighlightableTableViewCell where Self: UITableViewCell {
	
	var highlightBackgroundColor	: UIColor { get }
	
	var originalBackgroundColor		: UIColor { get }
	
	var highlightViewTag			: Int { get }
	
}
