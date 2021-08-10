//
//  AccountsViewModel.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/4/21.
//

import Combine
import Foundation

class AccountsViewModel: ObservableObject {
	@Published var accounts = [Account]()

	init() {
		fetchAccounts()
	}

	func fetchAccounts() {
		if let url = URL(string: "http://localhost:5555/accounts") {
			URLSession.shared.dataTaskPublisher(for: url)
				.map { $0.data }
				.decode(type: [Account].self, decoder: JSONDecoder())
				.replaceError(with: [])
				.eraseToAnyPublisher()
				.receive(on: DispatchQueue.main)
				.assign(to: &$accounts)
		}
	}
}
