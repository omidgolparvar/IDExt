//

import Foundation
import CommonCrypto

public extension Data {
	
	public var id_SHA512: String {
		var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
		let value =  self as NSData
		CC_SHA512(value.bytes, CC_LONG(self.count), &digest)
		var digestHex = ""
		for index in 0..<Int(CC_SHA512_DIGEST_LENGTH) {
			digestHex += String(format: "%02x", digest[index])
		}
		return digestHex.uppercased()
	}
	
	public var id_MD5: String {
		var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
		let value =  self as NSData
		CC_MD5(value.bytes, CC_LONG(self.count), &digest)
		var digestHex = ""
		for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
			digestHex += String(format: "%02x", digest[index])
		}
		return digestHex.uppercased()
	}
	
	
}
