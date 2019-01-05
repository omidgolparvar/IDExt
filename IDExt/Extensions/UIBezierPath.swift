//
//  UIBezierPath.swift
//  IDExt
//
//  Created by Omid Golparvar on 12/30/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation

public extension UIBezierPath {
	
	public static func ID_Initialize(square: CGRect, numberOfSides: UInt, cornerRadius: CGFloat) -> UIBezierPath? {
		guard square.width == square.height
			else { return nil }
		
		let squareWidth = square.width
		
		guard (numberOfSides > 0) && (cornerRadius >= 0.0) && (2.0 * cornerRadius < squareWidth) && !square.isInfinite && !square.isEmpty && !square.isNull
			else { return nil }
		
		let bezierPath = UIBezierPath()
		
		let theta =  2.0 * .pi / CGFloat(numberOfSides)
		let halfTheta = 0.5 * theta
		
		let offset: CGFloat = cornerRadius * CGFloat(tan(halfTheta))
		
		var length = squareWidth - bezierPath.lineWidth
		if numberOfSides % 4 > 0 {
			
			length = length * cos(halfTheta)
		}
		
		let sideLength = length * CGFloat(tan(halfTheta))
		
		let p1 = 0.5 * (squareWidth + sideLength) - offset
		let p2 = squareWidth - 0.5 * (squareWidth - length)
		var point = CGPoint(x: p1, y: p2)
		var angle = CGFloat.pi
		
		bezierPath.move(to: point)
		
		for _ in 0..<numberOfSides {
			
			let x1 = CGFloat(point.x) + ((sideLength - offset * 2.0) * CGFloat(cos(angle)))
			let y1 = CGFloat(point.y) + ((sideLength - offset * 2.0) * CGFloat(sin(angle)))
			
			point = CGPoint(x: x1, y: y1)
			bezierPath.addLine(to: point)
			
			let centerX = point.x + cornerRadius * CGFloat(cos(angle + 0.5 * .pi))
			let centerY = point.y + cornerRadius * CGFloat(sin(angle + 0.5 * .pi))
			let center = CGPoint(x: centerX, y: centerY)
			let startAngle = CGFloat(angle) - 0.5 * .pi
			let endAngle = CGFloat(angle) + CGFloat(theta) - 0.5 * .pi
			
			bezierPath.addArc(withCenter: center, radius: cornerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
			point = bezierPath.currentPoint
			angle += theta
			
		}
		
		bezierPath.close()
		
		return bezierPath
	}
	
}
