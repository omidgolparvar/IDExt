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
	
	//TODO	Func for BackgroundView (waiting and etc.)
	//TODO	Func for Display Message (normal message, error message and etc.)
	
}
