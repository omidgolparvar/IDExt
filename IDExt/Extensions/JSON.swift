//
//  JSON.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/14/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftyJSON

public extension JSON {
	
	public var id_IntFromIntOrString: Int? {
		return self.int ?? Int(self.string ?? "//")
	}
	
	public var id_HasStatusWithSuccessfulValue: Bool {
		guard let status = self["status"].id_IntFromIntOrString else { return false }
		return status == 1
	}
	
}
