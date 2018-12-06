//
//  IDPresenter.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/19/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import SwiftEntryKit

public final class IDPresenter {
	
	public typealias ActionSheetButtonItem = (title: String, color: UIColor, action: () -> Void)
	
	public static func DisplayError(_ error: IDErrorProtocol) {
		DisplayMessage(icon: "😕", title: "بروز خطا", message: error.message)
	}
	
	public static func DisplayMessage(icon: String?, title: String, message: String, textAlign: NSTextAlignment = .center) {
		let attributes = Message_EKAttributes
		
		var imageProperty: EKPopUpMessage.ThemeImage? = nil
		if let icon = icon {
			imageProperty = EKPopUpMessage.ThemeImage(image: EKProperty.ImageContent(image: icon.id_EmojiImage()!), position: .topToTop(offset: 24))
		}
		
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
		
		let popupMessage = EKPopUpMessage(themeImage: imageProperty, title: titleProperty, description: description, button: button, action: {
			SwiftEntryKit.dismiss()
		})
		let contentView = EKPopUpMessageView(with: popupMessage)
		SwiftEntryKit.display(entry: contentView, using: attributes)
		
	}
	
	public static func DisplaySheet(icon: String?, title: String, message: String, buttons: [ActionSheetButtonItem], dismissable: Bool = false) {
		var attributes = Sheet_EKAttributes
		attributes.screenInteraction = dismissable ? .dismiss : .absorbTouches
		
		var imageContent: EKProperty.ImageContent? = nil
		if let icon = icon {
			imageContent = EKProperty.ImageContent(image: icon.id_EmojiImage()!)
		}
		
		let titleContent = EKProperty.LabelContent(
			text: title,
			style: .init(font: Sheet_TitleFont, color: .black, alignment: .center)
		)
		
		let descriptionContent = EKProperty.LabelContent(
			text: message,
			style: .init(font: Sheet_MessageFont, color: .darkGray, alignment: .center)
		)
		
		let buttonsContent: [EKProperty.ButtonContent] = buttons.map { (button) in
			EKProperty.ButtonContent(
				label: EKProperty.LabelContent(
					text: button.title,
					style: .init(font: Sheet_ButtonFont, color: button.color, alignment: .center)
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
		
		let simpleMessage = EKSimpleMessage(image: imageContent, title: titleContent, description: descriptionContent)
		let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, imagePosition: .top, buttonBarContent: buttonBarContent)
		let contentView = EKAlertMessageView(with: alertMessage)
		SwiftEntryKit.display(entry: contentView, using: attributes)
	}
	
	public static func DisplayAlert(icon: String?, title: String, message: String, buttons: [ActionSheetButtonItem]) {
		
		var imageContent: EKProperty.ImageContent? = nil
		if let icon = icon {
			imageContent = EKProperty.ImageContent(image: icon.id_EmojiImage()!)
		}
		
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
		
		let simpleMessage = EKSimpleMessage(image: imageContent, title: titleContent, description: descriptionContent)
		let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, imagePosition: .top, buttonBarContent: buttonBarContent)
		let contentView = EKAlertMessageView(with: alertMessage)
		SwiftEntryKit.display(entry: contentView, using: Alert_EKAttributes)
	}
	
	public static func DisplayViewController(_ viewController: UIViewController, using attributes: EKAttributes = IDPresenter.DefaultEKAttributes) {
		SwiftEntryKit.display(entry: viewController, using: attributes)
	}
	
	public static func DisplayView(_ view: UIView, using attribures: EKAttributes = IDPresenter.DefaultEKAttributes) {
		SwiftEntryKit.display(entry: view, using: attribures)
	}
	
	public static func Dismiss(with completion: (() -> Void)? = nil) {
		SwiftEntryKit.dismiss(with: completion)
		
	}
	
}


