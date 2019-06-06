//

import Foundation
import Alamofire
import SwiftyJSON

public final class IDPaginator<Model: IDPaginatorModel> : CustomStringConvertible {
	
	internal var isVerbose		: Bool				= false
	public var items			: [Model]?			= nil
	public var currentPage		: Int				= 0
	public var identifier		: String?			= nil
	public var status			: PaginationStatus	= .shouldContinue
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
			
			_self.delegate?.idPaginator_TableView(_self).id_RemoveBackgroundView()
			_self.delegate?.idPaginator_DidGetResponse(_self, for: _self.currentPage, resultStatus: resultStatus, data: data)
			
			switch resultStatus {
			case .success:
				if let d = data {
					let json = IDMoya.JSON(d)
					_self.delegate?.idPaginator_DidEndLoading(_self, for: _self.currentPage, with: json)
					let arrayObjectKey = _self.delegate?.idPaginator_ArrayObjectName(_self)
					let array = arrayObjectKey == nil ? json.array : json[arrayObjectKey!].array
					if let arrayOfItems = array?.compactMap({ return Model(fromJSONObject: $0) }) {
						_self.appendNewItems(arrayOfItems)
						_self.currentPage += 1
						_self.setupStatusForLoadingNextPage(lastItems: arrayOfItems, jsonObject: json)
						_self.delegate?.idPaginator_DidEndLoading(_self, for: _self.currentPage-1, with: arrayOfItems)
						_self.delegate?.idPaginator_DidFinishLoading(_self, for: _self.currentPage-1)
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
				_self.delegate?.idPaginator_DidEndLoading(_self, for: _self.currentPage, with: .withData(data))
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
	
	public func item(at index: Int) -> Model? {
		if isVerbose {
			if let items = items {
				if !((0..<items.count) ~= index) {
					print("- IDPaginator: Invalid requested index.")
				}
			} else {
				print("- IDPaginator: Items is (nil).")
			}
		}
		return items?[safe: index]
	}
	
	public func resetToInitialState() {
		self.items			= nil
		self.currentPage	= 0
		self.status			= .shouldContinue
		self.delegate?.idPaginator_TableView(self).tableFooterView = nil
		self.delegate?.idPaginator_TableView(self).reloadData()
		self.delegate?.idPaginator_DidResetToInitialState(self)
	}
	
	private func appendNewItems(_ items: [Model]) {
		if self.items == nil {
			self.items = items
		} else {
			self.items!.append(contentsOf: items)
		}
	}
	
	private func setupStatusForLoadingNextPage(lastItems: [Model], jsonObject: IDMoya.JSON) {
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
