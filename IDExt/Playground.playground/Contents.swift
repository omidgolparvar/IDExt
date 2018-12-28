import UIKit
import SwiftyJSON
import IDExt

class Person {
	var name: String
	var age: Int
	init(name: String, age: Int) {
		self.name = name
		self.age = age
	}
	var dictionary: [String: Encodable] { return ["name": name, "age": age] }
}
let dictionary: [String: Encodable] = [
	"string"	: "Omid",
	"int"		: 29,
	"person"	: Person(name: "Omid Golparvar", age: 29).dictionary as! Encodable
]
print(dictionary)
print("Start...")

if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
	if let jsonString = String(data: jsonData, encoding: .utf8) {
		print(jsonString)
	} else {
		print("josn string failed.")
	}
} else {
	print("json data failed.")
}


print("DONE.")
