//
//  UIImage.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/25/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
	
	public static func ID_Initialize(generateQRCodeFromString string: String, scale: CGFloat = 3) -> UIImage? {
		guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
		let base64Data = string.data(using: .ascii)
		filter.setValue(base64Data, forKey: "inputMessage")
		let transform = CGAffineTransform(scaleX: scale, y: scale)
		guard let output = filter.outputImage?.transformed(by: transform) else { return nil }
		return UIImage(ciImage: output)
	}
	
}
