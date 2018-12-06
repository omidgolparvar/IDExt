//
//  IDMoya+ResponsechiDelegateProtocol.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/26/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public protocol IDMoyaResponsechiDelegate: NSObjectProtocol {
	
	var idMoya_HasNoConnectionHandler		: Bool { get }
	
	func idMoya_FailedBecauseOfNoConnection	(endpoint: IDMoyaEndpoint)
	func idMoya_FailedInSendingRequest		(endpoint: IDMoyaEndpoint, withError error: Error, andResultStatus result: IDMoya.ResultStatus?)
	
	func idMoya_RequestCanceled				(endpoint: IDMoyaEndpoint)
	func idMoya_FailedWithUnknownError		(endpoint: IDMoyaEndpoint, withData: Any)
	func idMoya_Succeeded					(endpoint: IDMoyaEndpoint, withResultStatus resultStatus: IDMoya.ResultStatus, data: Any?)
	
	func idMoya_ProcessorBlock				(endpoint: IDMoyaEndpoint) -> ((Any) -> Any?)?
	func idMoya_ProcessorResult				(endpoint: IDMoyaEndpoint, result: IDMoyaResponsechiProcessorResult)
	
}

extension IDMoyaResponsechiDelegate {
	
	var idMoya_HasNoConnectionHandler		: Bool { return false }
	
	func idMoya_FailedBecauseOfNoConnection	(endpoint: IDMoyaEndpoint) {}
	func idMoya_RequestCanceled				(endpoint: IDMoyaEndpoint) {}
	
	func idMoya_ProcessorBlock				(endpoint: IDMoyaEndpoint) -> ((Any) -> Any?)? { return nil }
	func idMoya_ProcessorResult				(endpoint: IDMoyaEndpoint, result: IDMoyaResponsechiProcessorResult) {}
	
}

public enum IDMoyaResponsechiProcessorResult {
	case successfull(object: Any)
	case failed(responseStatus: IDMoya.ResultStatus, reponseData: Any)
}

