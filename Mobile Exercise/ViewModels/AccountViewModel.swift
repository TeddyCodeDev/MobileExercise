//
//  AccountViewModel.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/8/21.
//

import Combine
import Foundation

class AccountViewModel: ObservableObject {
	@Published var transactions = [Transaction]()

	init(account: Account) {
		fetchAccounts(account: account)
	}

	func fetchAccounts(account: Account) {
		if let url = URL(string: "http://localhost:5555/transactions?accountId=\(account.id)") {
			URLSession.shared.dataTaskPublisher(for: url)
				.map { $0.data }
				.decode(type: [Transaction].self, decoder: JSONDecoder())
				.replaceError(with: [])
				.eraseToAnyPublisher()
				.receive(on: DispatchQueue.main)
				.assign(to: &$transactions)
		}
	}
}
