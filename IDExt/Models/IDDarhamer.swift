//
//  IDDarhamer.swift
//  IDExt
//
//  Created by Omid Golparvar on 1/1/19.
//  Copyright © 2019 Omid Golparvar. All rights reserved.
//

import Foundation

public final class IDDarhamer {
	
	public static weak var SharedDelegate: IDDarhamerDelegate!
	
	public static func BytesByObfuscating(string: String) -> [UInt8] {
		let salt = SharedDelegate!.idDarhamer_Salt.description
		let text = [UInt8](string.utf8)
		let cipher = [UInt8](salt.utf8)
		let length = cipher.count
		var encrypted = [UInt8]()
		for t in text.enumerated() {
			encrypted.append(t.element ^ cipher[t.offset % length])
		}
		
		IDApplication.OnlyInDevelopmentMode {
			print("""
				Original : \(string)
				Salt     : \(salt)
				[UInt8]  : \(encrypted)
				"""
			)
		}
		
		return encrypted
	}
	
	public static func Reveal(key: [UInt8]) -> String {
		let cipher = [UInt8](SharedDelegate!.idDarhamer_Salt.description.utf8)
		let length = cipher.count
		var decrypted = [UInt8]()
		for k in key.enumerated() {
			decrypted.append(k.element ^ cipher[k.offset % length])
		}
		return String(bytes: decrypted, encoding: .utf8)!
	}
	
}

