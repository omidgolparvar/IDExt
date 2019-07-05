//

import Foundation

public protocol IDDarhamerDelegate: NSObjectProtocol {
	
	var idDarhamer_Salt		: [Any]		{ get }
	
}

public final class IDDarhamer {
	
	public static weak var SharedDelegate: IDDarhamerDelegate?
	
	public static func Bytes(byObfuscating string: String) -> [UInt8] {
		guard let delegate = SharedDelegate else {
			fatalError("⚠️ IDDarhamer: SharedDelegate is NIL.")
		}
		let salt		= delegate.idDarhamer_Salt.description
		let text		= [UInt8](string.utf8)
		let cipher		= [UInt8](salt.utf8)
		let length		= cipher.count
		var encrypted	= [UInt8]()
		
		for t in text.enumerated() {
			encrypted.append(t.element ^ cipher[t.offset % length])
		}
		
		>>>"""
		Original : \(string)
		Salt     : \(salt)
		[UInt8]  : \(encrypted)
		"""
		
		return encrypted
	}
	
	public static func Reveal(key: [UInt8]) -> String {
		guard let delegate = SharedDelegate else {
			fatalError("⚠️ IDDarhamer: SharedDelegate is NIL.")
		}
		let cipher		= [UInt8](delegate.idDarhamer_Salt.description.utf8)
		let length		= cipher.count
		var decrypted	= [UInt8]()
		
		for k in key.enumerated() {
			decrypted.append(k.element ^ cipher[k.offset % length])
		}
		
		return String(bytes: decrypted, encoding: .utf8)!
	}
	
}

