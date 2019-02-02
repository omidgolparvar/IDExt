//
//  IDMoya+Uploader.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/13/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

public extension IDMoya {
	
	public final class Uploader {
		
		private var urlString			: String				= ""
		private var filesParameters		: [UploadParameter]		= []
		private var extraParameters		: Parameters?			= nil
		private var httpMethod			: Method				= .post
		private var headers				: Header?				= nil
		
		private var closure_Progress	: (Progress) -> Void	= { _ in }
		private var closure_Callback	: Callback				= { _, _ in }
		
		public var uploadRequest		: UploadRequest?		= nil
		
		public init(urlString: String, filesParameters: [UploadParameter], extraParameters: Parameters? = nil, callback: @escaping Callback) {
			self.urlString			= urlString
			self.filesParameters	= filesParameters
			self.extraParameters	= extraParameters
			self.closure_Callback	= callback
		}
		
		public func set(httpMethod: Method) {
			self.httpMethod = httpMethod
		}
		
		public func set(headers: Header) {
			self.headers = headers
		}
		
		public func onProgress(closure: @escaping (IDMoya.Progress) -> Void) {
			self.closure_Progress = closure
		}
		
		private func setupMultipartFormData(_ multipartFormData: MultipartFormData) {
			for filesParameter in filesParameters {
				multipartFormData.append(filesParameter.data, withName: filesParameter.name, fileName: filesParameter.fileName, mimeType: filesParameter.mimeType)
			}
			if let extraParameters = extraParameters {
				for (key, value) in extraParameters {
					multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
				}
			}
		}
		
		private func encodingResultHanlder(encodingResult: SessionManager.MultipartFormDataEncodingResult) {
			switch encodingResult {
			case .success(let uploadRequest, _, _):
				self.uploadRequest = uploadRequest
				uploadRequest.responseJSON { [weak self] response in
					guard let _self = self else { return }
					
					switch response.result {
					case .success(let json):
						let result = IDMoya.ResultStatus(rawValue: response.response?.statusCode ?? 0) ?? .unknown
						_self.closure_Callback(result, json as AnyObject)
						
					case .failure(let error):
						let nsError = error as NSError
						IsVerbose.id_IfIsTrue { print(ErrorMessagePrefix.id_Trimmed + " Uploader: " + nsError.id_ErrorStyleDescription) }
						switch nsError.code {
						case NSURLErrorCancelled	: _self.closure_Callback(.requestCanceled, nil)
						default						: _self.closure_Callback(.notRequested, nil)
						}
					}
				}
				
				uploadRequest.uploadProgress { [weak self] progress in
					self?.closure_Progress(progress)
				}
				
			case .failure(let error):
				IsVerbose.id_IfIsTrue { print(ErrorMessagePrefix.id_Trimmed + " Uploader: " + error.localizedDescription) }
				closure_Callback(.notRequested, nil)
			}
		}
		
		public func start() {
			guard !urlString.id_Trimmed.isEmpty, let url = URL(string: urlString) else { return }
			Alamofire.upload(multipartFormData: setupMultipartFormData, to: url, method: httpMethod, headers: headers) { [weak self] encodingResult in
				self?.encodingResultHanlder(encodingResult: encodingResult)
			}
		}
		
		public func cancel() {
			uploadRequest?.cancel()
		}
		
	}
	
	
}
