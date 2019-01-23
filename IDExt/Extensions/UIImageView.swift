//
//  UIImageView.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/23/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

public extension UIImageView {
	
	public func id_SetIDImage(_ image: IDImage, withType imageType: IDImage.ImageType) {
		self.kf.setImage(with: image.urlString(type: imageType).id_AsURL)
	}
	
}
