//
//  UserAuthViewModel.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/6/21.
//

import Combine
import Foundation
import SwiftUI

class UserAuthViewModel: ObservableObject {

	static let shared = UserAuthViewModel()

	@AppStorage("currentPage") var currentPage: Module = .accounts

	private init() {}

	func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> ()) {

		guard let url = URL(string: "http://localhost:5555/login") else { return }

		// See APIManager.sendPOSTRequest commented method for explanation
		//		APIManager.sendPOSTRequest(
		//			to: url,
		//			containing: [
		//				"username" : username,
		//				"password" : password
		//			]
		//		)

		APIManager.sendPOSTRequest(
			to: url,
			containing: [
				"username=\(username)",
				"password=\(password)"
			]
		) { result in
			switch result {
				case .success(let data):

					DispatchQueue.main.sync {
						self.currentPage = .accounts
					}

					// This line is more to insert the dummy data cause I'm not getting the user data from the server
					// If I was expecting data from the server I'd build out the error handling more and send a failure due to unexpected server response if I couldn't get a User object out of the data
					let user = !(data ?? Data()).isEmpty ? try? JSONDecoder().decode(User.self, from: data!) : User(id: 1, firstName: username, lastName: password)

					completion(.success(user!))

					print("Login Success")
					print(String(data: data ?? Data(), encoding: .utf8) ?? "Data not decodable")

				case .failure(let error):
					completion(.failure(error))

					print("Login Failed")
					print(error)
			}
		}
	}
}
