//

import Foundation
import SwiftyJSON
import Alamofire

public protocol IDPaginatorModel {
	
	init?(fromJSONObject json: IDMoya.JSON)
	
}

public protocol IDPaginatorTableViewCell where Self: IDTableViewCell {
	
	func idPaginatorTableViewCell_Setup<Model: IDPaginatorModel>(model: Model, indexPath: IndexPath)
	
}

