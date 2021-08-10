//
//  AccountTests.swift
//  Mobile ExerciseTests
//
//  Created by Tyler Barnes on 8/9/21.
//

import XCTest

@testable import Mobile_Exercise

class AccountTests: XCTestCase {

	func testInitialization() throws {

		let id = "1"
		let name = "Checking"
		let balance = 329.24

		let account = Account(id: id, name: name, balance: balance)

		XCTAssertEqual(account.id, id)
		XCTAssertEqual(account.name, name)
		XCTAssertEqual(account.balance, balance)
	}

	func testFormattedBalance() throws {
		let id = "1"
		let name = "Checking"
		let balance = 329.24

		let formattedBalance = "$329.24"

		let account = Account(id: id, name: name, balance: balance)

		XCTAssertEqual(account.id, id)
		XCTAssertEqual(account.name, name)
		XCTAssertEqual(account.balance, balance)

		XCTAssertEqual(account.formattedBalance, formattedBalance)
	}

}
