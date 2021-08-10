//
//  UserTests.swift
//  Mobile ExerciseTests
//
//  Created by Tyler Barnes on 8/9/21.
//

import XCTest

@testable import Mobile_Exercise

class UserTests: XCTestCase {

	func testInitialization() throws {

		let id = 1
		let firstName = "Johnny"
		let lastName = "Test"

		let user = User(id: id, firstName: firstName, lastName: lastName)

		XCTAssertEqual(user.id, id)
		XCTAssertEqual(user.firstName, firstName)
		XCTAssertEqual(user.lastName, lastName)
	}

	func testInitFromString() {

		let id = 1
		let firstName = "Johnny"
		let lastName = "Test"

		let user = User(id: id, firstName: firstName, lastName: lastName)

		let stringRepresentation = "{\"id\":1,\"firstName\":\"Johnny\",\"lastName\":\"Test\"}"

		var userFromString: User?
		self.measure {
			userFromString = User.from(string: stringRepresentation)
		}

		XCTAssertEqual(user.id, id)
		XCTAssertEqual(user.firstName, firstName)
		XCTAssertEqual(user.lastName, lastName)

		XCTAssertNotNil(userFromString)
		XCTAssertEqual(userFromString!.id, id)
		XCTAssertEqual(userFromString!.firstName, firstName)
		XCTAssertEqual(userFromString!.lastName, lastName)

		XCTAssertEqual(user, userFromString)

	}

	func testToString() {
		let id = 1
		let firstName = "Johnny"
		let lastName = "Test"

		let stringRepresentation = "{\"id\":1,\"firstName\":\"Johnny\",\"lastName\":\"Test\"}"

		let user = User(id: id, firstName: firstName, lastName: lastName)

		XCTAssertEqual(user.id, id)
		XCTAssertEqual(user.firstName, firstName)
		XCTAssertEqual(user.lastName, lastName)

		self.measure {
			XCTAssertEqual(user.toString(), stringRepresentation)
		}
	}

	func testDisplayName() throws {

		let id = 1
		let firstName = "Johnny"
		let lastName = "Test"

		let displayName = "Johnny Test"

		let user = User(id: id, firstName: firstName, lastName: lastName)

		XCTAssertEqual(user.id, id)
		XCTAssertEqual(user.firstName, firstName)
		XCTAssertEqual(user.lastName, lastName)

		self.measure {
			XCTAssertEqual(user.displayName, displayName)
		}
	}

}
