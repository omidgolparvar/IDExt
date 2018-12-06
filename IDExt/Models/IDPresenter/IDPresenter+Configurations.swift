//
//  IDPresenter+Configurations.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/19/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftEntryKit

extension IDPresenter {
	
	public static var Alert_EKAttributes	: EKAttributes = {
		var attributes = EKAttributes.centerFloat
		
		if #available(iOS 11, *) {
			attributes.entryBackground = .visualEffect(style: .extraLight)
		} else {
			attributes.entryBackground = .color(color: .white)
		}
		
		attributes.entranceAnimation = .init(
			translate	: nil,
			scale		: .init(from: 1.2, to: 1, duration: 0.2),
			fade		: .init(from: 0.0, to: 1, duration: 0.2)
		)
		attributes.displayDuration = .infinity
		attributes.shadow = .none
		attributes.statusBar = .dark
		attributes.scroll = .disabled
		attributes.entryInteraction = .absorbTouches
		attributes.screenInteraction = .absorbTouches
		attributes.positionConstraints.maxSize = .init(width: .constant(value: 300), height: .constant(value: 500))
		attributes.positionConstraints.verticalOffset = 12
		attributes.positionConstraints.size = .init(width: .offset(value: 12), height: .intrinsic)
		attributes.roundCorners = .all(radius: 8)
		attributes.screenBackground = .color(color: UIColor.black.withAlphaComponent(0.4))
		attributes.exitAnimation = .init(
			translate: nil,
			scale: nil,
			fade: .init(from: 1.0, to: 0.0, duration: 0.2)
		)
		
		return attributes
	}()
	
	public static var Alert_TitleFont		: UIFont	= UIFont.boldSystemFont(ofSize: 16)
	public static var Alert_MessageFont		: UIFont	= UIFont.systemFont(ofSize: 14)
	public static var Alert_ButtonFont		: UIFont	= UIFont.systemFont(ofSize: 16, weight: .medium)
	
	
	
	public static var Sheet_EKAttributes	: EKAttributes = {
		var attributes = EKAttributes.bottomFloat
		if #available(iOS 11, *) {
			attributes.entryBackground = .visualEffect(style: .extraLight)
		} else {
			attributes.entryBackground = .color(color: .white)
		}
		
		attributes.entranceAnimation = .init(
			translate: .init(duration: 0.5, anchorPosition: .bottom, delay: 0, spring: .init(damping: 1.0, initialVelocity: 1)),
			scale: nil,
			fade: nil
		)
		attributes.displayDuration = .infinity
		attributes.shadow = .none
		attributes.statusBar = .dark
		attributes.scroll = .disabled
		attributes.entryInteraction = .absorbTouches
		attributes.screenInteraction = .absorbTouches
		attributes.positionConstraints.maxSize = .init(width: .constant(value: 500), height: .constant(value: 700))
		attributes.positionConstraints.verticalOffset = 12
		attributes.positionConstraints.size = .init(width: .offset(value: 12), height: .intrinsic)
		attributes.roundCorners = .all(radius: 8)
		attributes.screenBackground = .color(color: UIColor.black.withAlphaComponent(0.4))
		attributes.exitAnimation = .init(
			translate: .init(duration: 0.2, anchorPosition: .bottom, delay: 0, spring: nil),
			scale: nil,
			fade: nil
		)
		
		return attributes
	}()
	
	public static var Sheet_TitleFont		: UIFont	= UIFont.boldSystemFont(ofSize: 16)
	public static var Sheet_MessageFont		: UIFont	= UIFont.systemFont(ofSize: 14)
	public static var Sheet_ButtonFont		: UIFont	= UIFont.systemFont(ofSize: 16, weight: .medium)
	
	
	
	public static var Message_EKAttributes	: EKAttributes = {
		var attributes = EKAttributes.centerFloat
		
		if #available(iOS 11, *) {
			attributes.entryBackground = .visualEffect(style: .extraLight)
		} else {
			attributes.entryBackground = .color(color: .white)
		}
		
		attributes.entranceAnimation = .init(
			translate: nil,
			scale: .init(from: 1.1, to: 1, duration: 0.1),
			fade: .init(from: 0.0, to: 1, duration: 0.1)
		)
		attributes.displayDuration = .infinity
		attributes.shadow = .none
		attributes.statusBar = .dark
		attributes.scroll = .disabled
		attributes.entryInteraction = .absorbTouches
		attributes.screenInteraction = .absorbTouches
		attributes.positionConstraints.maxSize = .init(width: .constant(value: 500), height: .constant(value: 500))
		attributes.roundCorners = .all(radius: 8)
		attributes.screenBackground = .color(color: UIColor.black.withAlphaComponent(0.4))
		attributes.exitAnimation = .init(
			translate: nil,
			scale: nil,
			fade: .init(from: 1.0, to: 0.0, duration: 0.2)
		)
		
		return attributes
	}()
	
	public static var Message_TitleFont		: UIFont	= UIFont.boldSystemFont(ofSize: 16)
	public static var Message_MessageFont	: UIFont	= UIFont.systemFont(ofSize: 14)
	public static var Message_ButtonFont	: UIFont	= UIFont.systemFont(ofSize: 16, weight: .medium)
	public static var Message_ButtonTitle	: String	= "بازگشت"
	
	
	
	public static var DefaultEKAttributes	: EKAttributes = {
		var attributes = EKAttributes()
		attributes.positionConstraints = .float
		attributes.positionConstraints.safeArea = .empty(fillSafeArea: false)
		attributes.windowLevel = .statusBar
		attributes.position = .center
		attributes.entryBackground = .color(color: .white)
		attributes.entranceAnimation = .init(
			translate	: nil,
			scale		: .init(from: 0.9, to: 1, duration: 0.4, delay: 0, spring: .init(damping: 1, initialVelocity: 1)),
			fade		: .init(from: 0.0, to: 1, duration: 0.2)
		)
		attributes.displayDuration = .infinity
		attributes.shadow = .none
		attributes.statusBar = .dark
		attributes.scroll = .disabled
		attributes.entryInteraction = .absorbTouches
		attributes.screenInteraction = .absorbTouches
		attributes.positionConstraints.maxSize = .init(width: .constant(value: 400), height: .constant(value: 600))
		attributes.positionConstraints.verticalOffset = 12
		attributes.positionConstraints.size = .init(width: .offset(value: 12), height: .intrinsic)
		attributes.roundCorners = .all(radius: 12)
		attributes.screenBackground = .color(color: UIColor.black.withAlphaComponent(0.4))
		attributes.exitAnimation = .init(
			translate	: nil,
			scale		: nil,
			fade		: .init(from: 1.0, to: 0.0, duration: 0.2)
		)
		
		return attributes
	}()
	
}
