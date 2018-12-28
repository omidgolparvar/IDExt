//
//  IDMoya+OAuthHandler.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/26/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public extension IDMoya {
	
	public final class OAuthHandler: RequestAdapter, RequestRetrier {
		
		public typealias OAuthObjectUserDefaultsKeys = (accessToken: String, refreshToken: String, expiresIn: String, createdAt: String)
		
		public static var SharedDelegate		: IDMoyaOAuthHandlerDelegate?	= nil
		
		private let sessionManager: SessionManager = {
			let configuration = URLSessionConfiguration.default
			configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
			return SessionManager(configuration: configuration)
		}()
		
		private let lock = NSLock()
		
		private var isRefreshing			: Bool = false
		
		private var oauthObject				: OAuthObject
		private var requestsToRetry			: [RequestRetryCompletion] = []
		
		public init(oauthObject: OAuthObject) {
			self.oauthObject = oauthObject
		}
		
		public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
			guard let sharedDelegate = OAuthHandler.SharedDelegate else {
				fatalError("IDMoya.OAuthHanlder.SharedDelegate is nil.")
			}
			return sharedDelegate.idMoyaOAuthHandler_AdaptURLRequest(urlRequest: urlRequest, with: oauthObject)
		}
		
		public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
			lock.lock() ; defer { lock.unlock() }
			
			guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
				completion(false, 0.0)
				return
			}
			
			requestsToRetry.append(completion)
			
			guard !isRefreshing else { return }
			
			refreshTokens { [weak self] succeeded, oauthObject in
				guard let strongSelf = self else { return }
				guard let sharedDelegate = OAuthHandler.SharedDelegate else {
					fatalError("IDMoya.OAuthHanlder.SharedDelegate is nil.")
				}
				
				strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
				
				if let oauthObject = oauthObject {
					sharedDelegate.idMoyaOAuthHandler_StoreNewOAuthObject(oauthObject)
					sharedDelegate.idMoyaOAuthHandler_DidSuccessfullyRefreshed(withNewOAuthObject: oauthObject)
					strongSelf.oauthObject = oauthObject
				} else {
					NotificationCenter.default.post(name: NotificationKeys.RefreshTokenFailed, object: nil)
				}
				
				strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
				strongSelf.requestsToRetry.removeAll()
			}
		}
		
		private func refreshTokens(completion: @escaping (_ succeeded: Bool, _ result: OAuthObject?) -> Void) {
			guard let sharedDelegate = OAuthHandler.SharedDelegate else {
				fatalError("IDMoya.OAuthHanlder.SharedDelegate is nil.")
			}
			guard !isRefreshing else { return }
			isRefreshing = true
			
			let refreshTokenEndpoint = sharedDelegate.idMoyaOAuthHanlder_RefreshTokenEndpoint(basedOn: oauthObject)
			sessionManager
				.request(refreshTokenEndpoint.fullPath, method: refreshTokenEndpoint.method, parameters: refreshTokenEndpoint.parameters, encoding: refreshTokenEndpoint.encoding)
				.responseJSON { [weak self] response in
					guard let strongSelf = self else { return }
					
					if	let json = response.result.value as? [String: Any],
						let oauthObject = OAuthObject(fromDictionary: json) {
						completion(true, oauthObject)
					} else {
						sharedDelegate.idMoyaOAuthHandler_DidFailedToRefresh(response: response)
						completion(false, nil)
					}
					strongSelf.isRefreshing = false
			}
		}
		
	}
	
}

public extension IDMoya.OAuthHandler {
	
	public final class NotificationKeys {
		
		public static var RefreshTokenFailed: Notification.Name { return .init("IDAM.NN.RefreshTokenFailed") }
		
	}
	
}


