//
//  IDTableViewHandler+Delegate.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/8/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

extension IDTableViewHandler: UITableViewDelegate {
	
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return delegate.heightForRowAtIndexPath(indexPath)
	}
	
	public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return delegate.heightForHeaderInSection(section)
	}
	
	public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return delegate.heightForFooterInSection(section)
	}
	
	public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return delegate.heightForRowAtIndexPath(indexPath)
	}
	
	public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return delegate.viewForHeaderInSection(section)
	}
	
	public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return delegate.viewForFooterInSection(section)
	}
	
	public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		return delegate.shouldHighlightRowAtIndexPath(indexPath)
	}
	
	public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
		delegate.didHighlightRowAtIndexPath(indexPath)
	}
	
	public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
		delegate.didUnhighlightRowAtIndexPath(indexPath)
	}
	
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		DispatchQueue.main.async { [weak self] in self?.delegate.didSelectRowAtIndexPath(indexPath) }
	}
	
	public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		DispatchQueue.main.async { [weak self] in self?.delegate.didDeselectRowAtIndexPath(indexPath) }
	}
	
}
