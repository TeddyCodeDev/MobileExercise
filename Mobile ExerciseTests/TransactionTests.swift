//
//  TransactionTests.swift
//  Mobile ExerciseTests
//
//  Created by Tyler Barnes on 8/9/21.
//

import XCTest

@testable import Mobile_Exercise

class TransactionTests: XCTestCase {

	func testInitialization() throws {

		let id = "1"
		let title = "Men's Wearhouse"
		let balance = 203.45

		let transaction = Transaction(id: id, title: title, balance: balance)

		XCTAssertEqual(transaction.id, id)
		XCTAssertEqual(transaction.title, title)
		XCTAssertEqual(transaction.balance, balance)
	}

	func testFormattedBalance() throws {
		let id = "1"
		let title = "Men's Wearhouse"
		let balance = 203.45

		let formattedBalance = "$203.45"

		let transaction = Transaction(id: id, title: title, balance: balance)

		XCTAssertEqual(transaction.id, id)
		XCTAssertEqual(transaction.title, title)
		XCTAssertEqual(transaction.balance, balance)

		XCTAssertEqual(transaction.formattedBalance, formattedBalance)
	}

}
