//
//  IDError.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/3/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public enum IDError: Error, CustomStringConvertible, IDErrorProtocol {
	
	case requestWithInvalidResponse
	case errorWithCustomMessage(String)
	case noConnection
	case withData(AnyObject?)
	case unAuthorized
	
	case unknownError
	
	public var description: String {
		switch self {
		case .requestWithInvalidResponse				: return "اطلاعات دریافتی معتبر نمی‌باشد"
		case .unknownError								: return "خطای غیر منتظره‌ای رخ داده است. کمی صبر کنید، و مجدد تلاش نمایید"
		case .errorWithCustomMessage(let message)		: return message
		case .noConnection:
			return "ارتباط با سامانه برقرار نشد. لطفا تنظیمات اینترنت را بررسی نمایید"
		case .withData(let data):
//			if let messages = Requester.GetErrorMessages(from: data) {
//				return Errors.errorMessages(messages).description
//			} else {
//				let message = Requester.GetErrorMessage(from: data)
//				return message
//			}
			return ""
		case .unAuthorized:
			return "می‌بایست مجدد وارد حساب کاربری خود شوید"
		}
	}
	
	public var message: String {
		return self.description
	}
	
}
