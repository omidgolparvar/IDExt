//
//  IDPaginatorDelegate.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/10/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol IDPaginatorDelegate: NSObjectProtocol {
	
	// MARK: Required
	
	func idPaginator_EndpointObject				<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> IDMoyaEndpointObject
	func idPaginator_TableView					<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> UITableView
	
	// MARK: Optionals
	
	func idPaginator_PageSize					<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> Int
	func idPaginator_PageParameterName			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> String
	func idPaginator_ArrayObjectName			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> String?
	func idPaginator_ExtraQueryParameter		<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int)	-> IDMoya.Parameters?
	func idPaginator_ViewForEmptyList			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> UIView?
	func idPaginator_ViewForLoadingFirstPage	<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> UIView?
	func idPaginator_ShouldLoadNextPage			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, lastItemsCount: Int, lastJSONObject jsonObject: IDMoya.JSON)	-> Bool
	
	
	func idPaginator_DidStartLoading			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int)
	func idPaginator_DidResetToInitialState		<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)
	func idPaginator_DidEndLoading				<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int, with items: [T])
	func idPaginator_DidEndLoading				<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int, with error: IDError)
	func idPaginator_DidEndLoading				<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int, with jsonObject: IDMoya.JSON)
	func idPaginator_DidFinishLoading			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int)
	
	
}

public extension IDPaginatorDelegate {
	
	// MARK: Default Implementations
	
	public func idPaginator_PageSize				<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> Int					{ return 20 }
	public func idPaginator_PageParameterName		<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> String				{ return "index"}
	public func idPaginator_ArrayObjectName			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> String?				{ return nil}
	public func idPaginator_ExtraQueryParameter		<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int)	-> IDMoya.Parameters?	{ return nil }
	public func idPaginator_ViewForEmptyList		<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> UIView?				{ return nil }
	public func idPaginator_ViewForLoadingFirstPage	<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> UIView?				{ return nil }
	
	public func idPaginator_ShouldLoadNextPage		<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, lastItemsCount: Int, lastJSONObject jsonObject: IDMoya.JSON)	-> Bool {
		return lastItemsCount >= self.idPaginator_PageSize(paginator)
	}
	
	public func idPaginator_DidStartLoading			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int) {
		let tableView = self.idPaginator_TableView(paginator)
		
		if page == 0 {
			if let firstPageLoadingView = self.idPaginator_ViewForLoadingFirstPage(paginator) {
				tableView.backgroundView = firstPageLoadingView
			} else {
				tableView.id_SetBackgroundWaitingView(isForWaiting: true)
			}
		} else {
			guard tableView.tableFooterView == nil else { return }
			let footerWaitingView = IDPaginationView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
			tableView.tableFooterView = footerWaitingView
		}
	}
	
	public func idPaginator_DidEndLoading			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int, with items: [T]) {
		paginator.isVerbose ???+ print("IDPaginator.DidEndLoading:ForPage: \(page), WithItems(Count): \(items.count)")
		let tableView = self.idPaginator_TableView(paginator)
		
		if page == 0, items.isEmpty {
			if let emptyListView = self.idPaginator_ViewForEmptyList(paginator) {
				tableView.backgroundView = emptyListView
			}
			tableView.tableFooterView = UIView(frame: .zero)
		} else {
			tableView.backgroundView = nil
			switch paginator.status {
			case .shouldNotContinue:
				tableView.tableFooterView = IDEndPaginationView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
			case .shouldContinue:
				let loadingMoreItemsView = IDPaginationView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
				tableView.tableFooterView = loadingMoreItemsView
			case .isLoading:
				break
			}
		}
		
		tableView.reloadData()
	}
	
	public func idPaginator_DidEndLoading			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int, with error: IDError) {
		paginator.isVerbose ???+ print("IDPaginator.DidEndLoading:ForPage: \(page), WithError: \(error.description)")
		
		let tableView = self.idPaginator_TableView(paginator)
		
		if page == 0 {
			tableView.id_SetBackgroundMessageView(forError: error, withAction: { paginator.loadNextPage() })
		} else {
			let paginationMessageView = IDPaginationMessageView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
			paginationMessageView.set(message: error.description, retryClosure: { paginator.loadNextPage() })
			tableView.tableFooterView = paginationMessageView
		}
	}
	
	public func idPaginator_DidEndLoading			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int, with jsonObject: IDMoya.JSON) {
		
	}
	
	public func idPaginator_DidResetToInitialState	<T: IDPaginatorModel>(_ paginator: IDPaginator<T>) {
		
	}
	
	public func idPaginator_DidFinishLoading		<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int) {
		
	}
	
}
