import UIKit

public class IDPaginationView: UIView {
	
	public static var TitleFont				: UIFont?
	public static var TitleColor			: UIColor?
	
	@IBOutlet public weak var activityIndicatorView	: UIActivityIndicatorView!
	@IBOutlet public weak var labelMessage				: UILabel!
	
	public var view: UIView!
	
	func xibSetup() {
		view = loadViewFromNib()
		view.frame = bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		addSubview(view)
		
		labelMessage.font = IDPaginationView.TitleFont ?? UIFont.systemFont(ofSize: 12)
		labelMessage.textColor = IDPaginationView.TitleColor ?? .lightGray
		
		
	}
	
	func loadViewFromNib() -> UIView {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: "IDPaginationView", bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
		return view
	}
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		xibSetup()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
	}
	
	public func startAnimating() {
		activityIndicatorView.startAnimating()
	}
	
	
	
}
