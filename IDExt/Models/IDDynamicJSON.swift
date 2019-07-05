//

import Foundation

@dynamicMemberLookup
public final class IDDynamicJSON: IDJSONInitBased, CustomStringConvertible {
	
	public var json: IDMoya.JSON?
	
	public var description: String {
		return json?.description ?? ""
	}
	
	public init?(fromData data: Data?) {
		guard let data = data else { return nil }
		let jsonObject = IDMoya.JSON(data)
		self.json = jsonObject
	}
	
	internal init(from json: IDMoya.JSON?) {
		self.json = json
	}
	
	public convenience init?(fromJSONObject jsonObject: IDMoya.JSON) {
		self.init(from: jsonObject)
	}
	
	public subscript(dynamicMember member: String) -> IDDynamicJSON? {
		return IDDynamicJSON(from: self.json?.dictionary?[member])
	}
	
}

