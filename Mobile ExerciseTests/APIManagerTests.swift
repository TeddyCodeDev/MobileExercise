//
//  APIManagerTests.swift
//  Mobile ExerciseTests
//
//  Created by Tyler Barnes on 8/9/21.
//

import XCTest

@testable import Mobile_Exercise

class APIManagerTests: XCTestCase {

	// TODO: Figure out how to effectively test Network Requests (I wrote them out and started throwing in breakpoints to find that it never hits the completion block...)
	
	// Tests written under the assumption that the mock server will not change (Tests could be configured to point at mock server and mock server data altered to expected values required to test various aspects
	func testGetRequestNoParameters() throws {

		let url = URL(string: "http://localhost:5555/accounts")

		APIManager.sendGETRequest(to: url!, with: []) { result in

			let data = try! result.get()

			XCTAssertNotNil(data)

			let accounts = try! JSONDecoder().decode([Account].self, from: data!)

			XCTAssertEqual(accounts.count, 3)
		}
	}

	func testGetRequestInvalidURL() throws {

		let url = URL(string: "http://localhost:5555/account")

		APIManager.sendGETRequest(to: url!, with: []) { result in

			let errorType = APIManager.HTTPError.serverSideError(404)

			if case .failure(let error) = result {
				XCTAssertEqual(error as? APIManager.HTTPError, errorType)
				return
			}

			XCTFail()
		}
	}

	func testGetRequestValidURLWithParameters() throws {

		let url = URL(string: "http://localhost:5555/transactions")
		let parameters = [URLQueryItem(name: "accountId", value: "1")]

		APIManager.sendGETRequest(to: url!, with: parameters) { result in

			let data = try! result.get()

			XCTAssertNotNil(data)

			let transactions = try! JSONDecoder().decode([Transaction].self, from: data!)

			XCTAssertEqual(transactions.count, 3)
		}
	}

	func testGetRequestValidURLWithOutParameters() throws {

		let url = URL(string: "http://localhost:5555/transactions")!
		//		let parameters = [URLQueryItem(name: "accountId", value: "1")]

		APIManager.sendGETRequest(to: url, with: []) { result in

			let errorType = APIManager.HTTPError.serverSideError(404)

			if case .failure(let error) = result {
				XCTAssertEqual(error as? APIManager.HTTPError, errorType)
				return
			}

			XCTFail()
		}
	}

	func testPostRequestValidUser() throws {

		let url = URL(string: "http://localhost:5555/login")!

		APIManager.sendPOSTRequest(
			to: url,
			containing: [
				"username=morty",
				"password=smith"
			]
		) { result in

			if case .failure(_) = result {
				XCTFail()
			}
		}
	}

	func testPostRequestInvalidUser() throws {

		let url = URL(string: "http://localhost:5555/login")!

		APIManager.sendPOSTRequest(
			to: url,
			containing: [
				"username=rick",
				"password=sanchez"
			]
		) { result in

			let errorType = APIManager.HTTPError.serverSideError(404) // I'd expect 403 but I'm not sure if the mock server is configured to send anything but 404 and 200

			if case .failure(let error) = result {
				XCTAssertEqual(error as? APIManager.HTTPError, errorType)
				return
			}

			XCTFail()
		}
	}

}
