//
//  IDPaginator.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/9/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public final class IDPaginator<T: IDPaginatorModel> : CustomStringConvertible {
	
	private var isVerbose		: Bool					= false
	private var items			: [T]?					= nil
	
	public var currentPage		: Int					= 0
	public var identifier		: String?				= nil
	public var status			: PaginationStatus		= .shouldContinue
	public weak var delegate	: IDPaginatorDelegate?
	
	public var description		: String {
		return """
			- IDPaginator: \(identifier == nil ? "" : "[\(identifier!)]")
			• Status = \(status)
			• Page   = \(currentPage)
			• Items  = \(items?.count ?? 0)
			
			"""
	}
	
	public init(delegate: IDPaginatorDelegate, identifier: String? = nil, isVerbose: Bool = false) {
		self.delegate	= delegate
		self.identifier	= identifier
		self.isVerbose	= isVerbose
	}
	
	public func loadNextPage() {
		guard let delegate = delegate else { return }
		guard status == .shouldContinue else { return }
		status = .isLoading
		
		delegate.idPaginator_DidStartLoading(self, for: currentPage)
		
		let endpointObject = delegate.idPaginator_EndpointObject(self)
		let pageParameterName = delegate.idPaginator_PageParameterName(self)
		endpointObject.addParameters([pageParameterName: currentPage])
		
		IDMoya.Perform(endpointObject) { [weak self] (resultStatus, data) in
			guard let _self = self else { return }
			
			switch resultStatus {
			case .success:
				if let d = data {
					let json = JSON(d)
					_self.delegate?.idPaginator_DidEndLoading(_self, for: _self.currentPage, with: json)
					let arrayObjectKey = _self.delegate?.idPaginator_ArrayObjectName(_self)
					let array = arrayObjectKey == nil ? json.array : json[arrayObjectKey!].array
					if let arrayOfItems = array?.compactMap({ return T(fromJSONObject: $0) }) {
						_self.appendNewItems(arrayOfItems)
						_self.delegate?.idPaginator_DidEndLoading(_self, for: _self.currentPage, with: arrayOfItems)
						_self.currentPage += 1
						_self.setupStatusForLoadingNextPage(lastItems: arrayOfItems, jsonObject: json)
					} else {
						_self.delegate?.idPaginator_DidEndLoading(_self, for: _self.currentPage, with: .requestWithInvalidResponse)
						_self.status = .shouldContinue
					}
				} else {
					_self.delegate?.idPaginator_DidEndLoading(_self, for: _self.currentPage, with: .requestWithInvalidResponse)
					_self.status = .shouldContinue
				}
			case .noConnection:
				_self.delegate?.idPaginator_DidEndLoading(_self, for: _self.currentPage, with: .noConnection)
				_self.status = .shouldContinue
			default:
				_self.delegate?.idPaginator_DidEndLoading(_self, for: _self.currentPage, with: .withData(data as AnyObject))
				_self.status = .shouldContinue
			}
			
		}
	}
	
	public func numberOfItems() -> Int {
		if isVerbose, items == nil {
			print("- IDPaginator: Items is (nil).")
		}
		return items?.count ?? 0
	}
	
	public func item(at index: Int) -> T? {
		if isVerbose {
			if let items = items {
				if !((0..<items.count) ~= index) {
					print("- IDPaginator: Invalid requested index.")
				}
			} else {
				print("- IDPaginator: Items is (nil).")
			}
		}
		return items?.id_SafeItem(at: index)
	}
	
	private func appendNewItems(_ items: [T]) {
		if self.items == nil {
			self.items = items
		} else {
			self.items!.append(contentsOf: items)
		}
	}
	
	private func setupStatusForLoadingNextPage(lastItems: [T], jsonObject: JSON) {
		guard let delegate = delegate else { return }
		status = delegate.idPaginator_ShouldLoadNextPage(self, lastItemsCount: lastItems.count, lastJSONObject: jsonObject) ?
			.shouldContinue :
			.shouldNotContinue
	}
	
	
	public enum PaginationStatus: CustomStringConvertible {
		case isLoading
		case shouldContinue
		case shouldNotContinue
		
		public var description: String {
			switch self {
			case .isLoading			: return "isLoading"
			case .shouldContinue	: return "shouldContinue"
			case .shouldNotContinue	: return "shouldNotContinue"
			}
		}
	}
	
}
