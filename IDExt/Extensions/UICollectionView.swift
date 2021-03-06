//
//  UICollectionView.swift
//  IDExt
//
//  Created by Omid Golparvar on 10/31/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UICollectionView {
	
	public func id_RegisterIDCell(_ cell: IDCollectionViewCell.Type) {
		let nib = UINib(nibName: cell.Identifier, bundle: nil)
		self.register(nib, forCellWithReuseIdentifier: cell.Identifier)
	}
	
	public func id_DequeueReusableIDCell<T: IDCollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
		return self.dequeueReusableCell(withReuseIdentifier: T.Identifier, for: indexPath) as! T
	}
	
	public func id_SetDelegateAndDataSource<T: UICollectionViewDelegate & UICollectionViewDataSource>(to object: T) {
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
	
	public func id_IDCellForItem<T: IDCollectionViewCell>(at indexPath: IndexPath) -> T {
		return self.cellForItem(at: indexPath) as! T
	}
	
	public func id_AddRefreshControl(action: Selector, setupHandler: ((UIRefreshControl) -> Void)? = nil) {
		let refreshControl = UIRefreshControl()
		setupHandler?(refreshControl)
		refreshControl.addTarget(self, action: action, for: .valueChanged)
		
		self.refreshControl = refreshControl
	}
	
}
