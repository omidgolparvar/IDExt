import UIKit
import IDExt

print("Hi :)")

class Person: CustomStringConvertible {
	var name: String
	var age: Int
	var description: String { return "\(name) - \(age)" }
	
	init(name: String, age: Int) {
		self.name = name
		self.age = age
	}
}

let people: [Person] = [
	.init(name: "Omid", age: 29),
	.init(name: "Ali", age: 15),
	.init(name: "Mamad", age: 27),
	.init(name: "Reza", age: 31),
	.init(name: "Gholi", age: 19),
]

//people.id_Sorted(by: \.age, ascending: true).forEach({ print($0) })
//people.id_Sorted(by: \.age, ascending: false).forEach({ print($0) })


