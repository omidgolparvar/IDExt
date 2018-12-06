
import UIKit

public class IDWaitingBackgroundView: UIView {
	
	public static var Font		: UIFont? = nil
	public static var Color		: UIColor? = nil
	
	@IBOutlet public weak var label				: UILabel!
	@IBOutlet public weak var activityIndicator	: UIActivityIndicatorView!
	
	var view: UIView!
	
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
		let nib = UINib(nibName: "IDWaitingBackgroundView", bundle: bundle)
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
		label.font = IDWaitingBackgroundView.Font ?? UIFont.systemFont(ofSize: 16)
		label.textColor = IDWaitingBackgroundView.Color ?? .darkGray
		activityIndicator.color = IDWaitingBackgroundView.Color ?? .darkGray
	}
	
}
