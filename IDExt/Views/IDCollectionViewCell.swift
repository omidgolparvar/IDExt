//

import UIKit

open class IDCollectionViewCell: UICollectionViewCell {
	
	public typealias HighlightModel = (view: UIView, normalColor: UIColor, highlightColor: UIColor)
	
	open class var Identifier: String {
		return String(describing: self)
	}
	
	open class var CellSize: CGSize {
		return .zero
	}
	
	
	open var highlightModel: HighlightModel? {
		return nil
	}
	
	open override var isHighlighted: Bool {
		get { return super.isHighlighted }
		set {
			if let highlightModel = highlightModel {
				let highlightView = highlightModel.view
				UIView.animate(withDuration: 0.2) {
					highlightView.backgroundColor = newValue ?
						highlightModel.highlightColor :
						highlightModel.normalColor
				}
			}
			
			super.isHighlighted = newValue
		}
	}
	
	open override func awakeFromNib() {
		super.awakeFromNib()
		
		if let highlightModel = highlightModel {
			highlightModel.view.backgroundColor = highlightModel.normalColor
		}
	}
}

