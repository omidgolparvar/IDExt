//
//  IDTableViewCell.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDTableViewCell: class {
	
	static var Identifier	: String { get }
	
	static var CellHeight	: CGFloat { get }
	
}

public extension IDTableViewCell {
	
	static var CellHeight: CGFloat {
		return UITableView.automaticDimension
	}
	
}
