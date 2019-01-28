//
//  IDMoya+Handlers.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/27/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import Alamofire

public extension IDMoya {
	
	internal static func HandleResponse(request: DataRequest?, response: IDMoya.DataResponse<Any>, endpoint: IDMoyaEndpoint, handler: ResponseHandler) {
		
		switch handler {
		case .callback(let callback)	: HandleResponse(response, endpoint, callback)
		case .delegate(let delegate)	: HandleResponse(response, endpoint, delegate)
		}
		
		if let request = request {
			let identifier = ObjectIdentifier(request)
			RequestsDictionary.removeValue(forKey: identifier)
		}
		
		UIApplication.shared.isNetworkActivityIndicatorVisible = !RequestsDictionary.isEmpty
	}
	
	internal static func HandleResponse(_ response: IDMoya.DataResponse<Any>, _ endpoint: IDMoyaEndpoint, _ callback: Callback) {
		switch response.result {
		case .success(let data):
			if let result = ResultStatus(rawValue: response.response!.statusCode) {
				callback(result, data as AnyObject)
			} else {
				callback(.unknown, data as AnyObject)
			}
		case .failure(let error):
			let nsError = error as NSError
			IsVerbose.id_IfIsTrue { print(ErrorMessagePrefix.id_Trimmed + " " + nsError.id_ErrorStyleDescription) }
			
			switch nsError.code {
			case NSURLErrorCancelled:
				callback(.requestCanceled, nil)
			default:
				callback(.notRequested, nil)
			}
		}
	}
	
	internal static func HandleResponse(_ response: IDMoya.DataResponse<Any>, _ endpoint: IDMoyaEndpoint, _ delegate: IDMoyaResponsechiDelegate?) {
		switch response.result {
		case .success(let data):
			if let result = ResultStatus(rawValue: response.response!.statusCode) {
				if let block = delegate?.idMoya_ProcessorBlock(endpoint: endpoint) {
					if let object = block(data) {
						delegate?.idMoya_ProcessorResult(endpoint: endpoint, result: .successfull(object: object))
					} else {
						delegate?.idMoya_ProcessorResult(endpoint: endpoint, result: .failed(responseStatus: result, reponseData: data))
					}
				} else {
					delegate?.idMoya_Succeeded(endpoint: endpoint, withResultStatus: result, data: data)
				}
			} else {
				delegate?.idMoya_FailedWithUnknownError(endpoint: endpoint, withData: data)
			}
		case .failure(let error):
			let nsError = error as NSError
			IsVerbose.id_IfIsTrue { print(ErrorMessagePrefix.id_Trimmed + " " + nsError.id_ErrorStyleDescription) }
			
			if	(error as NSError).code == NSURLErrorCancelled {
				delegate?.idMoya_RequestCanceled(endpoint: endpoint)
			} else if let afError = error as? AFError,
				case let .responseValidationFailed(reason) = afError,
				case let .unacceptableStatusCode(code) = reason {
				let resultStatus = ResultStatus(rawValue: code)
				delegate?.idMoya_FailedInSendingRequest(endpoint: endpoint, withError: error, andResultStatus: resultStatus)
			} else {
				delegate?.idMoya_FailedInSendingRequest(endpoint: endpoint, withError: error, andResultStatus: nil)
			}
			
		}
	}
	
	
}
