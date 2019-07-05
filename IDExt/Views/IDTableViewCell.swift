//

import UIKit

open class IDTableViewCell: UITableViewCell {
	
	public typealias HighlightModel = (view: UIView, normalColor: UIColor, highlightColor: UIColor)
	
	open class var Identifier: String {
		return String(describing: self)
	}
	
	open class var CellHeight: CGFloat {
		return UITableView.automaticDimension
	}
	
	
	open var highlightModel	: HighlightModel? {
		return nil
	}
	
	open override func awakeFromNib() {
		super.awakeFromNib()
		selectionStyle = .none
	}
	
	open override func setHighlighted(_ highlighted: Bool, animated: Bool) {
		if let highlightModel = highlightModel {
			let highlightView = highlightModel.view
			UIView.animate(withDuration: 0.2) {
				highlightView.backgroundColor = highlighted ?
					highlightModel.highlightColor :
					highlightModel.normalColor
			}
		}
		
		super.setHighlighted(highlighted, animated: animated)
	}
	
}

