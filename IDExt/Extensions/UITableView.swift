//
//  UITableView.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UITableView {
	
	public func id_RegisterIDCells<T: IDTableViewCell>(cellTypes: [T.Type]) {
		cellTypes.forEach { self.id_RegisterIDCell(cellType: $0) }
	}
	
	public func id_RegisterIDCells<T: IDTableViewCell>(cellClasses: [T.Type]) {
		cellClasses.forEach { self.id_RegisterIDCell(cellClass: $0) }
	}
	
	public func id_RegisterIDCell<T: IDTableViewCell>(cellType: T.Type) {
		let nib = UINib(nibName: cellType.Identifier, bundle: nil)
		self.register(nib, forCellReuseIdentifier: cellType.Identifier)
	}
	
	public func id_RegisterIDCell<T: IDTableViewCell>(cellClass: T.Type) {
		self.register(cellClass, forCellReuseIdentifier: cellClass.Identifier)
	}
	
	public func id_DequeueReusableIDCell<T: IDTableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
		return self.dequeueReusableCell(withIdentifier: type.Identifier, for: indexPath) as! T
	}
	
	public func id_RemoveExtraSeparatorLines() {
		self.tableFooterView = UIView.ID_WithZeroFrame
	}
	
	public func id_SetHeights(rowHeight: CGFloat, estimatedRowHeight: CGFloat) {
		self.rowHeight = rowHeight
		self.estimatedRowHeight = estimatedRowHeight
	}
	
	public func id_SetAutomaticDimensionHeights() {
		self.rowHeight = UITableView.automaticDimension
		self.estimatedRowHeight = UITableView.automaticDimension
	}
	
	public func id_ScrollToTop(animated: Bool = true) {
		self.setContentOffset(.zero, animated: animated)
	}
	
	public func id_SafeScrollToRow(at indexPath: IndexPath, at position: UITableView.ScrollPosition = .top, animated: Bool = true) {
		guard
			self.numberOfSections >= indexPath.section,
			self.numberOfRows(inSection: indexPath.section) >= indexPath.row
			else { return }
		self.scrollToRow(at: indexPath, at: position, animated: animated)
	}
	
	public func id_SetDelegateAndDataSource<T: UITableViewDelegate & UITableViewDataSource>(to object: T) {
		self.delegate	= object
		self.dataSource	= object
	}
	
	//TODO	Func for PaginationView
	//TODO	Func for BackgroundView (waiting and etc.)
	//TODO	Func for Display Message (normal message, error message and etc.)
	
}
