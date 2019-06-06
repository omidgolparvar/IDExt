//
//  IDError.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/3/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum IDError: Error, CustomStringConvertible, IDErrorProtocol {
	
	case requestWithInvalidResponse
	case errorWithCustomMessage(String)
	case noConnection
	case withData(Any?)
	case unAuthorized
	case unknownError
	
	public var description: String {
		switch self {
		case .requestWithInvalidResponse:
			return "اطلاعات دریافتی معتبر نمی‌باشد"
		case .unknownError:
			return "خطای غیر منتظره‌ای رخ داده است. کمی صبر کنید، و مجدد تلاش نمایید"
		case .errorWithCustomMessage(let message):
			return message
		case .noConnection:
			return "ارتباط با سامانه برقرار نشد. لطفا تنظیمات اینترنت را بررسی نمایید"
		case .withData(let data):
			guard let data = data else { return IDError.unknownError.description }
			let jsonObject = IDMoya.JSON(data)
			if let array = jsonObject.array {
				let messages = array.compactMap({ $0["message"].string?.id_Trimmed }).filter({ !$0.isEmpty })
				return messages.isEmpty ? IDError.unknownError.description : messages.joined(separator: "\n")
			}
			if let message = jsonObject["message"].string {
				return message
			}
			return IDError.unknownError.description
		case .unAuthorized:
			return "می‌بایست مجدد وارد حساب کاربری خود شوید"
		}
	}
	
	public var message: String {
		return self.description
	}
	
}
