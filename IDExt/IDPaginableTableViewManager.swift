//

import Foundation

public typealias IDPaginableTableViewManagerType =
	UITableViewDelegate &
	UITableViewDataSource &
	IDPaginatorDelegate

open class IDPaginableTableViewManager <Model: IDPaginatorModel, Cell: IDPaginatorTableViewCell> : NSObject, IDPaginableTableViewManagerType {
	
	public typealias TableViewTapHandler	= (Model, IndexPath) -> Void
	
	private var initializeStyle	: InitializeStyle
	
	public var paginatorObject	: IDPaginator<Model>!
	
	public init(_ initializeStyle: InitializeStyle) {
		self.initializeStyle = initializeStyle
		
		super.init()
		
		switch initializeStyle {
		case .objective(let object):
			object.tableView.delegate = self
			object.tableView.dataSource = self
			
			paginatorObject = IDPaginator<Model>(delegate: self)
			
		case .delegative(let object):
			paginatorObject = IDPaginator<Model>(delegate: object.paginatorDelegate)
			
		}
	}
	
	
	//MARK: UITableViewDataSource
	
	open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return paginatorObject?.numberOfItems() ?? 0
		
	}
	
	open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.id_DequeueReusableIDCell(Cell.self, for: indexPath)
		cell.idPaginatorTableViewCell_Setup(model: paginatorObject!.item(at: indexPath.row)!, indexPath: indexPath)
		return cell
	}
	
	
	//MARK: UITableViewDelegate
	
	open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard case let .objective(object) = self.initializeStyle else { return }
		let model = self.paginatorObject!.item(at: indexPath.row)!
		0.0.id_AfterSecondsPerform {
			object.tableViewTapHandler(model, indexPath)
		}
	}
	
	open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		guard case let .objective(object) = self.initializeStyle else { fatalError("IDPaginableTableViewManager: \(#function): Wrong InitializeStyle.") }
		return object.tableViewCellHeight
	}
	
	open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		guard case let .objective(object) = self.initializeStyle else { fatalError("IDPaginableTableViewManager: \(#function): Wrong InitializeStyle.") }
		return object.tableViewCellHeight
	}
	
	
	//MARK: IDPaginatorDelegate
	
	open func idPaginator_EndpointObject<T>(_ paginator: IDPaginator<T>) -> IDMoyaEndpoint where T : IDPaginatorModel {
		guard case let .objective(object) = self.initializeStyle else { fatalError("IDPaginableTableViewManager: \(#function): Wrong InitializeStyle.") }
		return object.paginationEndpoint
	}
	
	open func idPaginator_TableView<T>(_ paginator: IDPaginator<T>) -> UITableView where T : IDPaginatorModel {
		guard case let .objective(object) = self.initializeStyle else { fatalError("IDPaginableTableViewManager: \(#function): Wrong InitializeStyle.") }
		return object.tableView
	}
	
	open func idPaginator_ViewForEmptyList<T>(_ paginator: IDPaginator<T>) -> UIView? where T : IDPaginatorModel {
		guard case let .objective(object) = self.initializeStyle else { fatalError("IDPaginableTableViewManager: \(#function): Wrong InitializeStyle.") }
		return object.emptyListView
	}
	
}

public extension IDPaginableTableViewManager {
	
	public enum InitializeStyle {
		
		public class ObjectiveObject {
			internal var paginationEndpoint		: IDMoyaEndpoint
			internal var tableView				: UITableView
			internal var tableViewCellHeight	: CGFloat
			internal var tableViewTapHandler	: TableViewTapHandler
			internal var emptyListView			: UIView?
			
			public init(paginationEndpoint	: IDMoyaEndpoint,
						tableView			: UITableView,
						tableViewCellHeight	: CGFloat						= UITableView.automaticDimension,
						emptyListView		: UIView?						= nil,
						tableViewTapHandler	: @escaping TableViewTapHandler	= { (_, _) in }) {
				
				self.paginationEndpoint = paginationEndpoint
				self.tableView = tableView
				self.tableViewCellHeight = tableViewCellHeight
				self.emptyListView = emptyListView
				self.tableViewTapHandler = tableViewTapHandler
			}
		}
		
		public class DelegativeObject {
			internal weak var paginatorDelegate	: IDPaginatorDelegate!
			
			public init(paginatorDelegate	: IDPaginatorDelegate) {
				self.paginatorDelegate = paginatorDelegate
			}
		}
		
		case objective(object: ObjectiveObject)
		case delegative(object: DelegativeObject)
	}
	
}
