//
//  IDMoya+EndpointProtocol.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/26/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDMoyaEndpoint {
	
	var identifier		: String?				{ get }
	var baseURLString	: String				{ get }
	var path			: String				{ get }
	var method			: IDMoya.Method			{ get }
	var encoding		: IDMoya.Encoding		{ get }
	var parameters		: IDMoya.Parameters?	{ get }
	var headers			: IDMoya.Header?		{ get }
	var useOAuth		: Bool					{ get }
	
}

public final class IDMoyaEndpointObject: IDMoyaEndpoint {
	
	private var _identifier		: String?
	public var identifier		: String?				{ return _identifier }
	
	private var _baseURLString	: String
	public var baseURLString	: String					{ return _baseURLString }
	
	private var _path			: String
	public var path				: String				{ return _path }
	
	private var _method			: IDMoya.Method
	public var method			: IDMoya.Method			{ return _method }
	
	private var _encoding		: IDMoya.Encoding
	public var encoding			: IDMoya.Encoding		{ return _encoding }
	
	private var _parameters		: IDMoya.Parameters?
	public var parameters		: IDMoya.Parameters?	{ return _parameters }
	
	private var _headers		: IDMoya.Header?
	public var headers			: IDMoya.Header?		{ return _headers }
	
	private var _useOAuth		: Bool
	public var useOAuth			: Bool					{ return _useOAuth }
	
	public var fullPath			: String {
		return baseURLString + path
	}
	
	public init(identifier		: String? = nil,
				baseURLString	: String,
				path			: String,
				method			: IDMoya.Method,
				encoding		: IDMoya.Encoding,
				parameters		: IDMoya.Parameters?,
				headers			: IDMoya.Header?,
				useOAuth		: Bool) {
		
		self._identifier	= identifier
		self._baseURLString	= baseURLString
		self._path			= path
		self._method		= method
		self._encoding		= encoding
		self._parameters	= parameters
		self._headers		= headers
		self._useOAuth		= useOAuth
	}
	
	public func addParameters(_ params: [String: Any]) {
		if self._parameters == nil {
			self._parameters = [:]
		}
		for (key, value) in params {
			self._parameters![key] = value
		}
	}
	
	public func setParameters(_ params: [String: Any]) {
		self._parameters = params
	}
	
	
	
}
