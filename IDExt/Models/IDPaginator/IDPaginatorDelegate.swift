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
	
	
	func idPaginator_DidStartLoading			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int)
	func idPaginator_DidEndLoading				<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int, with items: [T])
	func idPaginator_DidEndLoading				<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int, with error: IDError)
	func idPaginator_DidEndLoading				<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int, with jsonObject: JSON)
	
	
}

public extension IDPaginatorDelegate {
	
	// MARK: Default Implementations
	
	func idPaginator_PageSize					<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> Int					{ return 20 }
	func idPaginator_PageParameterName			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> String				{ return "index"}
	func idPaginator_ArrayObjectName			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> String?				{ return nil}
	func idPaginator_ExtraQueryParameter		<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int)	-> IDMoya.Parameters?	{ return nil }
	func idPaginator_ViewForEmptyList			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> UIView?				{ return nil }
	func idPaginator_ViewForLoadingFirstPage	<T: IDPaginatorModel>(_ paginator: IDPaginator<T>)					-> UIView?				{ return nil }
	
	
	func idPaginator_DidStartLoading			<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int) {
		//TODO check isVerbose and print data
		let tableView = self.idPaginator_TableView(paginator)
		
		if page == 0 {
			if let firstPageLoadingView = self.idPaginator_ViewForLoadingFirstPage(paginator) {
				tableView.backgroundView = firstPageLoadingView
			} else {
				//TODO
				//tableView.setupKipoBackgroundView(isForWaiting: true)
			}
		} else {
			//TODO
			//guard tableView.tableFooterView == nil else { return }
			//let footerWaitingView = PaginationView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
			//tableView.tableFooterView = footerWaitingView
		}
	}
	
	func idPaginator_DidEndLoading				<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int, with items: [T]) {
		//TODO check isVerbose and print data
		let tableView = self.idPaginator_TableView(paginator)
		
		if page == 0, items.count == 0 {
			if let emptyListView = self.idPaginator_ViewForEmptyList(paginator) {
				tableView.backgroundView = emptyListView
			}
			tableView.tableFooterView = UIView(frame: .zero)
		} else {
			tableView.backgroundView = nil
			switch paginator.status {
			case .shouldNotContinue:
				//TODO setup end pagination view
				//let noMoreItemView = EndPaginationView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
				//tableView.tableFooterView = noMoreItemView
				break
			case .shouldContinue:
				//TODO setup loading pagination view
				//let loadingMoreItemsView = PaginationView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
				//tableView.tableFooterView = loadingMoreItemsView
				break
			case .isLoading:
				break
			}
		}
		
		tableView.reloadData()
	}
	
	func idPaginator_DidEndLoading				<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int, with error: IDError) {
		//TODO check isVerbose and print data
		let tableView = self.idPaginator_TableView(paginator)
		
		if page == 0 {
			//TODO setup error view
			//tableView.setupKipoBackgroundView(with: error, handler: { paginator.closureForRetry() })
		} else {
			//TODO setup pagination error view
			//let paginationMessageView = PaginationMessageView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
			//paginationMessageView.set(message: error.description, retryClosure: { paginator.closureForRetry() })
			//tableView.tableFooterView = paginationMessageView
		}
	}
	
	func idPaginator_DidEndLoading				<T: IDPaginatorModel>(_ paginator: IDPaginator<T>, for page: Int, with jsonObject: JSON) {
		
	}
	
}
