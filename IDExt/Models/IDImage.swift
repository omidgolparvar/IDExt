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

public protocol IDImageDelegate: NSObjectProtocol {
	var idImage_BaseURLString: String { get }
}

public final class IDImage {
	
	public static weak var SharedDelegate: IDImageDelegate?
	
	public var id				: String = ""
	public var ratio			: Double = 1.0
	public var contentType		: String = ""
	public var baseURLString	: String? = nil
	
	public init?(from json: IDMoya.JSON) {
		guard
			let _id = json["id"].string,
			let _ratio = json["ratio"].double,
			let _contentType = json["content_type"].string
			else { return nil }
		id = _id
		ratio = _ratio
		contentType = _contentType
	}
	
	public func urlString(type: ImageType, contentTypeIdentifier: String? = nil) -> String {
		guard let delegate = IDImage.SharedDelegate else {
			fatalError("⚠️ IDImage: SharedDelegate is NIL.")
		}
		let contentType = contentTypeIdentifier ?? self.contentType.id_ReplacedFirstOccurrence(of: "image", with: "")
		return delegate.idImage_BaseURLString + id + "/" + type.rawValue.ps.string + contentType
	}
	
	public var jsonString: String {
		return "{\"id\":\"\(id)\", \"content_type\":\"\(contentType)\", \"ratio\": \(ratio)}"
	}
	
	public enum ImageType: Int {
		case original	= 1
		case compressed	= 2
		case thumbnail	= 3
	}
	
}
