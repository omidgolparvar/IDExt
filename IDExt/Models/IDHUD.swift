//
//  IDHUD.swift
//  IDExt
//
//  Created by Omid Golparvar on 11/19/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import Foundation
import PKHUD

public final class IDHUD {
	
	public static var DimsBackground		: Bool {
		get { return PKHUD.sharedHUD.dimsBackground }
		set { PKHUD.sharedHUD.dimsBackground = newValue }
	}
	
	public static var TitleFont		: UIFont	= UIFont.ID_Font(ofSize: 17, weight: .bold)
	public static var SubtitleFont	: UIFont	= UIFont.ID_Font(ofSize: 14, weight: .regular)
	public static var MessageFont	: UIFont	= UIFont.ID_Font(ofSize: 17, weight: .regular)
	
	public static func Show(_ content: HUDContentType) {
		PKHUD.sharedHUD.contentView = ContentView(content)
		PKHUD.sharedHUD.show()
	}
	
	public static func Flash(_ content: HUDContentType, duration: TimeInterval, completion: ((Bool) -> Void)? = nil) {
		PKHUD.sharedHUD.contentView = ContentView(content)
		PKHUD.sharedHUD.show()
		PKHUD.sharedHUD.hide(afterDelay: duration, completion: completion)
	}
	
	public static func Hide(animated: Bool = true, completion: PKHUD.TimerAction?) {
		PKHUD.sharedHUD.hide(animated, completion: completion)
	}
	
	
	private static func ContentView(_ content: HUDContentType) -> UIView {
		switch content {
		case .success:
			return PKHUDSuccessView()
			
		case .error:
			return PKHUDErrorView()
			
		case .progress:
			return PKHUDProgressView()
			
		case let .image(image):
			return PKHUDSquareBaseView(image: image)
			
		case let .rotatingImage(image):
			return PKHUDRotatingImageView(image: image)
			
		case let .labeledSuccess(title, subtitle):
			let view = PKHUDSuccessView(title: title, subtitle: subtitle)
			view.titleLabel.font = TitleFont
			view.subtitleLabel.font = SubtitleFont
			return view
			
		case let .labeledError(title, subtitle):
			let view = PKHUDErrorView(title: title, subtitle: subtitle)
			view.titleLabel.font = TitleFont
			view.subtitleLabel.font = SubtitleFont
			return view
			
		case let .labeledProgress(title, subtitle):
			let view = PKHUDProgressView(title: title, subtitle: subtitle)
			view.titleLabel.font = TitleFont
			view.subtitleLabel.font = SubtitleFont
			return view
			
		case let .labeledImage(image, title, subtitle):
			let view = PKHUDSquareBaseView(image: image, title: title, subtitle: subtitle)
			view.titleLabel.font = TitleFont
			view.subtitleLabel.font = SubtitleFont
			return view
			
		case let .labeledRotatingImage(image, title, subtitle):
			let view = PKHUDRotatingImageView(image: image, title: title, subtitle: subtitle)
			view.titleLabel.font = TitleFont
			view.subtitleLabel.font = SubtitleFont
			return view
			
		case let .label(text):
			let textView = PKHUDTextView(text: text)
			textView.titleLabel.font = MessageFont
			return textView
			
		case .systemActivity:
			return PKHUDSystemActivityIndicatorView()
			
		case let .customView(view):
			return view
		}
	}
	
}
