//
//  IDMoya+TargetTypeProtocol.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/26/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDMoyaEndpoint {
	
	var baseURL		: URL { get }
	
	var path		: String { get }
	
	var method		: IDMoya.Method { get }
	
	var encoding	: IDMoya.Encoding { get }
	
	var parameters	: IDMoya.Parameters? { get }
	
	var headers		: IDMoya.Header? { get }
	
	var useOAuth	: Bool { get }
	
}
