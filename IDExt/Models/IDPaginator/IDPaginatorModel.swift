//
//  IDPaginatorModel.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/10/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

public protocol IDPaginatorModel {
	
	init?(fromJSONObject json: JSON)
	
}

