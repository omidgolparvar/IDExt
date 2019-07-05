//
//  UITableView.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UITableView {
	
	public func id_RegisterIDCell<T: IDTableViewCell>(cellType: T.Type) {
		let nib = UINib(nibName: cellType.Identifier, bundle: nil)
		self.register(nib, forCellReuseIdentifier: cellType.Identifier)
	}
	
	public func id_DequeueReusableIDCell<T: IDTableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
		return self.dequeueReusableCell(withIdentifier: type.Identifier, for: indexPath) as! T
	}
	
	public func id_RemoveExtraSeparatorLines() {
		self.tableFooterView = UIView(frame: .zero)
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
	
	public func id_SafelyScrollToRow(at indexPath: IndexPath, position: UITableView.ScrollPosition = .top, animated: Bool = true) {
		guard
			self.numberOfSections > indexPath.section,
			self.numberOfRows(inSection: indexPath.section) > indexPath.row
			else { return }
		self.scrollToRow(at: indexPath, at: position, animated: animated)
	}
	
	public func id_SetDelegateAndDataSource<T: UITableViewDelegate & UITableViewDataSource>(to object: T) {
		self.delegate	= object
		self.dataSource	= object
	}
	
	public func id_RemoveBackgroundView() {
		self.backgroundView = nil
	}
	
	public func id_SetBackgroundWaitingView(isForWaiting: Bool) {
		self.backgroundView = isForWaiting ? IDWaitingBackgroundView(frame: self.frame.id_SameWidthAndHight()) : nil
	}
	
	public func id_SetBackgroundMessageView(emoji: String, title: String, message: String, buttonConfig: (title: String, handler: () -> Void)?) {
		var messageView = IDMessageBackgroundView(frame: self.frame.id_SameWidthAndHight())
			.setEmoji(emoji)
			.setTexts(title: title, message: message)
		
		if let config = buttonConfig {
			messageView = messageView.setActionButton(title: config.title, action: config.handler)
		}
		
		self.backgroundView = messageView
	}
	
	public func id_SetBackgroundMessageView(forError error: IDError, withAction action: @escaping () -> Void) {
		let messageView = IDMessageBackgroundView(frame: self.frame.id_SameWidthAndHight())
			.setError(error, action: action)
		
		self.backgroundView = messageView
	}
	
	public func id_SetPaginationView(hasPagination: Bool) {
		if hasPagination {
			let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 80.0)
			let paginationView = IDPaginationView(frame: frame)
			self.tableFooterView = paginationView
		} else {
			self.tableFooterView = UIView(frame: .zero)
		}
	}
	
	public func id_IDCellForItem<T: IDTableViewCell>(at indexPath: IndexPath) -> T {
		return self.cellForRow(at: indexPath) as! T
	}
	
	public func id_AddRefreshControl(action: Selector, setupHandler: ((UIRefreshControl) -> Void)? = nil) {
		let refreshControl = UIRefreshControl()
		setupHandler?(refreshControl)
		refreshControl.addTarget(self, action: action, for: .valueChanged)
		
		self.refreshControl = refreshControl
	}
	
}
