import UIKit

class IDEndPaginationView: UIView {
	
	public static var TitleFont		: UIFont?
	public static var TitleColor	: UIColor?
	
	@IBOutlet weak var label_Title	: UILabel!
	
	var view: UIView!
	
	func xibSetup() {
		view = loadViewFromNib()
		view.frame = bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		addSubview(view)
		
		label_Title.font = IDEndPaginationView.TitleFont ?? .systemFont(ofSize: 12, weight: .medium)
		label_Title.textColor = IDEndPaginationView.TitleColor ?? .lightGray
	}
	
	func loadViewFromNib() -> UIView {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: "IDEndPaginationView", bundle: bundle)
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
	
}
