import UIKit

public class IDMessageBackgroundView: UIView {
	
	public static var TitleFont						: UIFont?
	public static var TitleColor					: UIColor?
	
	public static var MessageFont					: UIFont?
	public static var MessageColor					: UIColor?
	
	public static var ActionButtonFont				: UIFont?
	public static var ActionButtonBackgroundColor	: UIColor?
	
	public static var DismissButtonFont				: UIFont?
	public static var DismissButtonText				: String?
	public static var DismissButtonWidth			: CGFloat?
	
	
	@IBOutlet public weak var label_Icon					: UILabel!
	@IBOutlet public weak var label_Title					: UILabel!
	@IBOutlet public weak var label_Message					: UILabel!
	@IBOutlet public weak var button_Action					: UIButton!
	@IBOutlet public weak var button_Dismiss				: UIButton!
	@IBOutlet public weak var constraint_DismissButtonWidth	: NSLayoutConstraint!
	
	private var closure_Action	: () -> Void = { }
	private var closure_Dismiss	: () -> Void = { }
	
	public var view: UIView!
	
	func xibSetup() {
		view = loadViewFromNib()
		view.frame = bounds
		view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
		view.clipsToBounds = true
		addSubview(view)
		initialSetup()
	}
	
	func loadViewFromNib() -> UIView {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: "IDMessageBackgroundView", bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
		return view
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		xibSetup()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
	}
	
	private func initialSetup() {
		label_Icon.isHidden = true
		
		label_Title.font = IDMessageBackgroundView.TitleFont ?? .boldSystemFont(ofSize: 16)
		label_Title.textColor = IDMessageBackgroundView.TitleColor ?? .black
		
		label_Message.font = IDMessageBackgroundView.MessageFont ?? .systemFont(ofSize: 14)
		label_Message.textColor = IDMessageBackgroundView.MessageColor ?? .darkGray
		
		button_Action.titleLabel?.font = IDMessageBackgroundView.ActionButtonFont ?? .boldSystemFont(ofSize: 14)
		button_Action.backgroundColor = IDMessageBackgroundView.ActionButtonBackgroundColor ?? .ID_Initialize(hexCode: "#F0F0F0")
		button_Action.isHidden = true
		
		button_Dismiss.titleLabel?.font = IDMessageBackgroundView.DismissButtonFont ?? .systemFont(ofSize: 11)
		button_Dismiss.setTitle(IDMessageBackgroundView.DismissButtonText ?? "بستن", for: .normal)
		button_Dismiss.isHidden = true
		
		constraint_DismissButtonWidth.constant = IDMessageBackgroundView.DismissButtonWidth ?? 50.0
		
		layoutIfNeeded()
	}
	
	
	public func setEmoji(_ emoji: String) -> IDMessageBackgroundView {
		label_Icon.isHidden = false
		label_Icon.text = emoji
		return self
	}
	
	public func setTexts(title: String, message: String) -> IDMessageBackgroundView {
		label_Title.text = title
		label_Message.text = message
		return self
	}
	
	public func setActionButton(title: String?, action callback: @escaping () -> Void) -> IDMessageBackgroundView {
		button_Action.isHidden = false
		button_Action.setTitle(title ?? "تلاش مجدد", for: .normal)
		closure_Action = callback
		return self
	}
	
	public func setError(_ error: IDError, action: @escaping () -> Void) -> IDMessageBackgroundView {
		return self
			.setEmoji("😕")
			.setTexts(title: "بروز خطا", message: error.description)
	}
	
	public func setCloseClosure(_ closeClosure: @escaping () -> Void) -> IDMessageBackgroundView {
		self.closure_Dismiss = closeClosure
		self.button_Dismiss.isHidden = false
		return self
	}
	
	
	@IBAction internal func actionActionButton(_ sender: UIButton) {
		closure_Action()
	}
	
	@IBAction internal func actionDismissButton(_ sender: UIButton) {
		closure_Dismiss()
	}

}
