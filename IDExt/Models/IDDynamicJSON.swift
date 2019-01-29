//
//  IDDynamicJSON.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/3/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftyJSON

@dynamicMemberLookup
public final class IDDynamicJSON: IDJSONInitBased {
	
	public var json: IDMoya.JSON?
	
	public init(from json: IDMoya.JSON?) {
		self.json = json
		
	}
	
	public convenience init?(fromJSONObject jsonObject: IDMoya.JSON) {
		self.init(from: jsonObject)
	}
	
	public subscript(dynamicMember member: String) -> IDDynamicJSON? {
		return IDDynamicJSON(from: self.json?.dictionary?[member])
	}
	
}

extension IDDynamicJSON: CustomStringConvertible {
	
	public var description: String {
		return json?.description ?? ""
	}
	
}
