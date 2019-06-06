//
//  IDPresenter.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/19/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftEntryKit
import SPStorkController

public final class IDPresenter {
	
	public typealias TextAndColor			= (text: String, color: UIColor?)
	public typealias ActionSheetButtonItem	= (title: String, color: UIColor, action: () -> Void)
	public typealias Attributes				= EKAttributes
	public typealias BackgroundStyle		= EKAttributes.BackgroundStyle
	public typealias DisplayDuration		= EKAttributes.DisplayDuration
	
	public static func DisplayNotifiaction(image: UIImage?, title: TextAndColor, message: TextAndColor, textAlign: NSTextAlignment = .right, entryBackground: BackgroundStyle? = nil, displayDuration: DisplayDuration? = nil) {
		
		var attributes = Notification_EKAttributes
		if let entryBackground = entryBackground {
			attributes.entryBackground = entryBackground
		}
		if let displayDuration = displayDuration {
			attributes.displayDuration = displayDuration
		}
		
		var imageContent: EKProperty.ImageContent?
		if let image = image {
			imageContent = EKProperty.ImageContent(image: image)
		}
		
		let titleContent = EKProperty.LabelContent(
			text: title.text,
			style: .init(font: Notification_TitleFont, color: title.color ?? .black, alignment: .center)
		)
		let descriptionContent = EKProperty.LabelContent(
			text: message.text,
			style: .init(font: Notification_MessageFont, color: message.color ?? .darkGray, alignment: .center)
		)
		
		let simpleMessage = EKSimpleMessage(image: imageContent, title: titleContent, description: descriptionContent)
		let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
		let contentView = EKNotificationMessageView(with: notificationMessage)
		SwiftEntryKit.display(entry: contentView, using: attributes)
	}
	
	public static func DisplayError(_ error: IDErrorProtocol) {
		DisplayMessage(title: "بروز خطا", message: error.message)
	}
	
	public static func DisplayMessage(title: String, message: String, textAlign: NSTextAlignment = .center) {
		let attributes = Message_EKAttributes
		
		let titleProperty = EKProperty.LabelContent(
			text: title,
			style: .init(font: Message_TitleFont, color: .black, alignment: .center)
		)
		
		let description = EKProperty.LabelContent(
			text: message,
			style: .init(font: Message_MessageFont, color: .darkGray, alignment: textAlign)
		)
		let button = EKProperty.ButtonContent(
			label: EKProperty.LabelContent(
				text: Message_ButtonTitle,
				style: .init(font: Message_ButtonFont, color: .black, alignment: .center)
			),
			backgroundColor: .clear,
			highlightedBackgroundColor: .white,
			action: {}
		)
		
		let popupMessage = EKPopUpMessage(title: titleProperty, description: description, button: button, action: {
			SwiftEntryKit.dismiss()
		})
		let contentView = EKPopUpMessageView(with: popupMessage)
		SwiftEntryKit.display(entry: contentView, using: attributes)
		
	}
	
	public static func DisplayActionSheet(title: String, message: String, buttons: [ActionSheetButtonItem], isDismissable: Bool = false) {
		var attributes = ActionSheet_EKAttributes
		attributes.screenInteraction = isDismissable ? .dismiss : .absorbTouches
		
		let titleContent = EKProperty.LabelContent(
			text: title,
			style: .init(font: ActionSheet_TitleFont, color: .black, alignment: .center)
		)
		
		let descriptionContent = EKProperty.LabelContent(
			text: message,
			style: .init(font: ActionSheet_MessageFont, color: .darkGray, alignment: .center)
		)
		
		let buttonsContent: [EKProperty.ButtonContent] = buttons.map { (button) in
			EKProperty.ButtonContent(
				label: EKProperty.LabelContent(
					text: button.title,
					style: .init(font: ActionSheet_ButtonFont, color: button.color, alignment: .center)
				),
				backgroundColor: .clear,
				highlightedBackgroundColor: .white,
				action: { SwiftEntryKit.dismiss(with: { button.action() }) }
			)
		}
		
		var buttonBarContent: EKProperty.ButtonBarContent!
		switch buttonsContent.count {
		case 0:
			return
		case 1:
			buttonBarContent = EKProperty.ButtonBarContent(
				with:	buttonsContent[0],
				separatorColor: UIColor.lightGray.withAlphaComponent(0.5), buttonHeight: 56.0, expandAnimatedly: false
			)
		case 2:
			buttonBarContent = EKProperty.ButtonBarContent(
				with:	buttonsContent[0],
				buttonsContent[1],
				separatorColor: UIColor.lightGray.withAlphaComponent(0.5), buttonHeight: 56.0, expandAnimatedly: false
			)
		case 3:
			buttonBarContent = EKProperty.ButtonBarContent(
				with:	buttonsContent[0],
				buttonsContent[1],
				buttonsContent[2],
				separatorColor: UIColor.lightGray.withAlphaComponent(0.5), buttonHeight: 56.0, expandAnimatedly: false
			)
		case 4:
			buttonBarContent = EKProperty.ButtonBarContent(
				with:	buttonsContent[0],
				buttonsContent[1],
				buttonsContent[2],
				buttonsContent[3],
				separatorColor: UIColor.lightGray.withAlphaComponent(0.5), buttonHeight: 56.0, expandAnimatedly: false
			)
		case 5:
			buttonBarContent = EKProperty.ButtonBarContent(
				with:	buttonsContent[0],
				buttonsContent[1],
				buttonsContent[2],
				buttonsContent[3],
				buttonsContent[4],
				separatorColor: UIColor.lightGray.withAlphaComponent(0.5), buttonHeight: 56.0, expandAnimatedly: false
			)
		case 6:
			buttonBarContent = EKProperty.ButtonBarContent(
				with:	buttonsContent[0],
				buttonsContent[1],
				buttonsContent[2],
				buttonsContent[3],
				buttonsContent[4],
				buttonsContent[5],
				separatorColor: UIColor.lightGray.withAlphaComponent(0.5), buttonHeight: 56.0, expandAnimatedly: false
			)
		case 7:
			buttonBarContent = EKProperty.ButtonBarContent(
				with:	buttonsContent[0],
				buttonsContent[1],
				buttonsContent[2],
				buttonsContent[3],
				buttonsContent[4],
				buttonsContent[5],
				buttonsContent[6],
				separatorColor: UIColor.lightGray.withAlphaComponent(0.5), buttonHeight: 56.0, expandAnimatedly: false
			)
		case 8:
			buttonBarContent = EKProperty.ButtonBarContent(
				with:	buttonsContent[0],
				buttonsContent[1],
				buttonsContent[2],
				buttonsContent[3],
				buttonsContent[4],
				buttonsContent[5],
				buttonsContent[6],
				buttonsContent[7],
				separatorColor: UIColor.lightGray.withAlphaComponent(0.5), buttonHeight: 56.0, expandAnimatedly: false
			)
		default:
			return
		}
		
		let simpleMessage = EKSimpleMessage(image: nil, title: titleContent, description: descriptionContent)
		let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, buttonBarContent: buttonBarContent)
		let contentView = EKAlertMessageView(with: alertMessage)
		SwiftEntryKit.display(entry: contentView, using: attributes)
	}
	
	public static func DisplayAlert(title: String, message: String, buttons: [ActionSheetButtonItem]) {
		let titleContent = EKProperty.LabelContent(
			text: title,
			style: .init(font: Alert_TitleFont, color: .black, alignment: .center)
		)
		
		let descriptionContent = EKProperty.LabelContent(
			text: message,
			style: .init(font: Alert_MessageFont, color: .darkGray, alignment: .center)
		)
		
		let buttonsContent: [EKProperty.ButtonContent] = buttons.map { (button) in
			EKProperty.ButtonContent(
				label: EKProperty.LabelContent(
					text: button.title,
					style: .init(font: Alert_ButtonFont, color: button.color, alignment: .center)
				),
				backgroundColor: .clear,
				highlightedBackgroundColor: .white,
				action: { SwiftEntryKit.dismiss(with: { button.action() }) }
			)
		}
		
		var buttonBarContent: EKProperty.ButtonBarContent!
		switch buttonsContent.count {
		case 0:
			return
		case 1:
			buttonBarContent = EKProperty.ButtonBarContent(
				with:	buttonsContent[0],
				separatorColor: UIColor.lightGray.withAlphaComponent(0.5), buttonHeight: 56.0, expandAnimatedly: false
			)
		case 2:
			buttonBarContent = EKProperty.ButtonBarContent(
				with:	buttonsContent[0],
				buttonsContent[1],
				separatorColor: UIColor.lightGray.withAlphaComponent(0.5), buttonHeight: 56.0, expandAnimatedly: false
			)
		case 3:
			buttonBarContent = EKProperty.ButtonBarContent(
				with:	buttonsContent[0],
				buttonsContent[1],
				buttonsContent[2],
				separatorColor: UIColor.lightGray.withAlphaComponent(0.5), buttonHeight: 56.0, expandAnimatedly: false
			)
		case 4:
			buttonBarContent = EKProperty.ButtonBarContent(
				with:	buttonsContent[0],
				buttonsContent[1],
				buttonsContent[2],
				buttonsContent[3],
				separatorColor: UIColor.lightGray.withAlphaComponent(0.5), buttonHeight: 56.0, expandAnimatedly: false
			)
		case 5:
			buttonBarContent = EKProperty.ButtonBarContent(
				with:	buttonsContent[0],
				buttonsContent[1],
				buttonsContent[2],
				buttonsContent[3],
				buttonsContent[4],
				separatorColor: UIColor.lightGray.withAlphaComponent(0.5), buttonHeight: 56.0, expandAnimatedly: false
			)
		default:
			return
		}
		
		let simpleMessage = EKSimpleMessage(image: nil, title: titleContent, description: descriptionContent)
		let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, buttonBarContent: buttonBarContent)
		let contentView = EKAlertMessageView(with: alertMessage)
		SwiftEntryKit.display(entry: contentView, using: Alert_EKAttributes)
	}
	
	public static func DisplayViewController(_ viewController: UIViewController, using attributes: Attributes = IDPresenter.DefaultEKAttributes) {
		SwiftEntryKit.display(entry: viewController, using: attributes)
	}
	
	public static func Dismiss(_ completion: (() -> Void)? = nil) {
		SwiftEntryKit.dismiss(with: completion)
	}
	
	public static func DisplayStorky(_ source: UIViewController, destination: UIViewController, delegate: IDStorkyPresenterDelegate? = nil) {
		let transitionDelegate = SPStorkTransitioningDelegate()
		
		if let delegate = delegate {
			transitionDelegate.swipeToDismissEnabled = delegate.idStorkyPresenter_IsSwipeToDismissEnabled(for: destination)
			transitionDelegate.tapAroundToDismissEnabled = delegate.idStorkyPresenter_IsTapAroundToDismissEnabled(for: destination)
			transitionDelegate.showIndicator = delegate.idStorkyPresenter_ShowIndicator(for: destination)
			transitionDelegate.indicatorColor = delegate.idStorkyPresenter_IndicatorColor(for: destination)
			transitionDelegate.customHeight = delegate.idStorkyPresenter_CustomHeight(for: destination)
			transitionDelegate.cornerRadius = delegate.idStorkyPresenter_CornerRadius(for: destination)
		}
		
		destination.transitioningDelegate = transitionDelegate
		destination.modalPresentationStyle = .custom
		destination.modalPresentationCapturesStatusBarAppearance = true
		source.present(destination, animated: true, completion: nil)
	}
	
}



