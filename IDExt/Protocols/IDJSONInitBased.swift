//
//  IDJSONInitBased.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/23/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol IDJSONInitBased {
	
	init?(fromJSONObject jsonObject: IDMoya.JSON)
	
}
