//
//  IDTableViewHandler+DataSource.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/8/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

extension IDTableViewHandler: UITableViewDataSource {
	
	public func numberOfSections(in tableView: UITableView) -> Int {
		return dataSource.numberOfSections()
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource.numberOfRowsInSection(section)
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return dataSource.cellForRowAtIndexPath(tableView, indexPath)
	}
	
	public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return dataSource.titleForHeaderInSection(section)
	}
	
	public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		return dataSource.titleForFooterInSection(section)
	}
	
}
