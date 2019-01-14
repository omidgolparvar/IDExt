//
//  IDTableViewHandler.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/8/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation


public final class IDTableViewHandler: NSObject {
	
	public typealias DataSource	= (
		numberOfSections				: () -> Int,
		numberOfRowsInSection			: (Int) -> Int,
		cellForRowAtIndexPath			: (UITableView, IndexPath) -> UITableViewCell,
		titleForHeaderInSection			: (Int) -> String?,
		titleForFooterInSection			: (Int) -> String?
	)
	public typealias Delegate	= (
		heightForRowAtIndexPath			: (IndexPath) -> CGFloat,
		heightForHeaderInSection		: (Int) -> CGFloat,
		heightForFooterInSection		: (Int) -> CGFloat,
		viewForHeaderInSection			: (Int) -> UIView?,
		viewForFooterInSection			: (Int) -> UIView?,
		shouldHighlightRowAtIndexPath	: (IndexPath) -> Bool,
		didHighlightRowAtIndexPath		: (IndexPath) -> Void,
		didUnhighlightRowAtIndexPath	: (IndexPath) -> Void,
		didSelectRowAtIndexPath			: (IndexPath) -> Void,
		didDeselectRowAtIndexPath		: (IndexPath) -> Void
	)
	
	weak var tableView	: UITableView!
	
	var dataSource		: DataSource
	var delegate		: Delegate
	
	public init(for tableView: UITableView) {
		self.tableView = tableView
		
		dataSource = (
			{ return 1 },
			{ _ in return 0 },
			{ _, _ in fatalError("IDTableViewHandler.DataSource.CellForRowAtIndexPath: not implemented.") },
			{ _ in return nil },
			{ _ in return nil }
		)
		
		delegate = (
			{ _ in return UITableView.automaticDimension },
			{ _ in return 64.0 },
			{ _ in return 64.0 },
			{ _ in return nil },
			{ _ in return nil },
			{ _ in return true },
			{ _ in },
			{ _ in },
			{ _ in },
			{ _ in }
		)
		
		super.init()
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
	}
	
	
	public func setupTableView(_ closure: (UITableView) -> Void) -> IDTableViewHandler {
		closure(tableView)
		return self
	}
	
	public func registerTableViewCells<T: IDTableViewCell>(_ types: [T.Type]) -> IDTableViewHandler {
		types.forEach { tableView.id_RegisterIDCell(cellType: $0) }
		return self
	}
	
	
	//MARK: DataSource Closures
	
	public func forNumberOfSections(_ closure: @escaping () -> Int) -> IDTableViewHandler {
		dataSource.numberOfSections = closure
		return self
	}
	
	public func forNumberOfRowsInSection(_ closure: @escaping (Int) -> Int) -> IDTableViewHandler {
		dataSource.numberOfRowsInSection = closure
		return self
	}
	
	public func forCellForRowAtIndexPath(_ closure: @escaping (UITableView, IndexPath) -> UITableViewCell) -> IDTableViewHandler {
		dataSource.cellForRowAtIndexPath = closure
		return self
	}
	
	public func forTitleForHeaderInSection(_ closure: @escaping (Int) -> String?) -> IDTableViewHandler {
		dataSource.titleForHeaderInSection = closure
		return self
	}
	
	public func forTitleForFooterInSection(_ closure: @escaping (Int) -> String?) -> IDTableViewHandler {
		dataSource.titleForFooterInSection = closure
		return self
	}
	
	
	//MARK: Delegate Closures
	
	public func forHeightForRowAtIndexPath(_ closure: @escaping (IndexPath) -> CGFloat) -> IDTableViewHandler {
		delegate.heightForRowAtIndexPath = closure
		return self
	}
	
	public func forHeightForHeaderInSection(_ closure: @escaping (Int) -> CGFloat) -> IDTableViewHandler {
		delegate.heightForHeaderInSection = closure
		return self
	}
	
	public func forHeightForFooterInSection(_ closure: @escaping (Int) -> CGFloat) -> IDTableViewHandler {
		delegate.heightForFooterInSection = closure
		return self
	}
	
	public func forViewForHeaderInSection(_ closure: @escaping (Int) -> UIView?) -> IDTableViewHandler {
		delegate.viewForHeaderInSection = closure
		return self
	}
	
	public func forViewForFooterInSection(_ closure: @escaping (Int) -> UIView?) -> IDTableViewHandler {
		delegate.viewForFooterInSection = closure
		return self
	}
	
	public func forShouldHighlightRowAtIndexPath(_ closure: @escaping (IndexPath) -> Bool) -> IDTableViewHandler {
		delegate.shouldHighlightRowAtIndexPath = closure
		return self
	}
	
	public func forDidHighlightRowAtIndexPath(_ closure: @escaping (IndexPath) -> Void) -> IDTableViewHandler {
		delegate.didHighlightRowAtIndexPath = closure
		return self
	}
	
	public func forDidUnhighlightRowAtIndexPath(_ closure: @escaping (IndexPath) -> Void) -> IDTableViewHandler {
		delegate.didUnhighlightRowAtIndexPath = closure
		return self
	}
	
	public func forDidSelectRowAtIndexPath(_ closure: @escaping (IndexPath) -> Void) -> IDTableViewHandler {
		delegate.didSelectRowAtIndexPath = closure
		return self
	}
	
	public func forDidDeselectRowAtIndexPath(_ closure: @escaping (IndexPath) -> Void) -> IDTableViewHandler {
		delegate.didDeselectRowAtIndexPath = closure
		return self
	}
	
	
	
	
	
}





