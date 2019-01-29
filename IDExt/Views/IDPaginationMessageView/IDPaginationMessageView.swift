import UIKit

class IDPaginationMessageView: UIView {
	
	public static var TitleFont				: UIFont?
	public static var TitleColor			: UIColor?
	
	public static var ButtonFont			: UIFont?
	public static var ButtonTextColor		: UIColor?
	public static var ButtonBackgroundColor	: UIColor?
	
	@IBOutlet weak var labelMessage	: UILabel!
	@IBOutlet weak var buttonRetry	: UIButton!
	
	private var retryClosure		: () -> Void = { }
	
	var view: UIView!
	
	func xibSetup() {
		view = loadViewFromNib()
		view.frame = bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		addSubview(view)
		
		labelMessage.font = IDPaginationMessageView.TitleFont ?? UIFont.systemFont(ofSize: 12)
		labelMessage.textColor = IDPaginationMessageView.TitleColor ?? .red
		
		buttonRetry.titleLabel?.font = IDPaginationMessageView.ButtonFont ?? UIFont.systemFont(ofSize: 11)
		buttonRetry.backgroundColor = IDPaginationMessageView.ButtonBackgroundColor ?? .black
		buttonRetry.titleLabel?.textColor = IDPaginationMessageView.ButtonTextColor ?? .white
		buttonRetry.layer.cornerRadius = 8.0
		buttonRetry.clipsToBounds = true
	}
	
	func loadViewFromNib() -> UIView {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: "IDPaginationMessageView", bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
		return view
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		xibSetup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
	}
	
	func set(message: String, retryClosure: @escaping () -> Void) {
		labelMessage.text = message
		self.retryClosure = retryClosure
	}
	
	@IBAction func actionRetry(_ sender: UIButton) {
		retryClosure()
	}
	
}
