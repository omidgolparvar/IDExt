//
//  IDImage.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/21/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

public final class IDImage {
	
	public static var BaseURLString	: () -> String	= {
		return ""
	}
	
	public var id			: String = ""
	public var ratio		: Double = 1.0
	public var contentType	: String = ""
	
	public init?(from json: JSON) {
		guard
			let _id = json["id"].string,
			let _ratio = json["ratio"].double,
			let _contentType = json["content_type"].string
			else { return nil }
		id = _id
		ratio = _ratio
		contentType = _contentType
	}
	
	public func urlString(baseURLString: String = IDImage.BaseURLString(), type: ImageType, contentTypeIdentifier: String? = nil) -> String {
		let contentType = contentTypeIdentifier ?? self.contentType.id_ReplacedFirstOccurrence(of: "image", with: "")
		return baseURLString + id + "/" + type.rawValue.ps.string + contentType
	}
	
	public enum ImageType: Int {
		case original	= 1
		case compressed	= 2
		case thumbnail	= 3
	}
	
}
