//
//  User.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/4/21.
//

import Foundation

struct User: Hashable, Codable, Identifiable {

	var id: Int

	var firstName: String
	var lastName: String

	// Helpers For Display
	private var firstNameTitleCase: String {
		let firstLetter = firstName.dropLast(firstName.count - 1)
		return "\(firstLetter.uppercased())\(firstName.dropFirst().lowercased())"
	}
	private var lastNameTitleCase: String {
		let firstLetter = lastName.dropLast(lastName.count - 1)
		return "\(firstLetter.uppercased())\(lastName.dropFirst().lowercased())"
	}
	
	var displayName: String { return "\(firstNameTitleCase) \(lastNameTitleCase)" }
}

extension User {

	func toString() -> String {
		guard let data = try? JSONEncoder().encode(self) else { return "" }

		return String(data: data, encoding: .utf8) ?? ""
	}

	static func from(string stringRepresentation: String) -> User? {
		guard let data = stringRepresentation.data(using: .utf8) else { return nil }

		return try? JSONDecoder().decode(User.self, from: data)
	}
}
