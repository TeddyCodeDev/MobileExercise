//
//  AccountSummary.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/8/21.
//

import SwiftUI

struct AccountSummary: View {

	@EnvironmentObject var accountViewModel: AccountViewModel

	var account: Account

	@State var menuOpen = false

	var body: some View {
		List {
			AccountRow(account: account)
			Section(header: Text("Transactions")) {
				ForEach(accountViewModel.transactions) { transaction in
					TransactionRow(transaction: transaction)
				}
			}
		}
		.navigationBarTitleDisplayMode(.inline)
		.navigationTitle(account.name)
	}
}

struct AccountSummary_Previews: PreviewProvider {
	static var previews: some View {
		let account = Account(id: "1", name: "Test Account", balance: 2542.21)

		AccountSummary(account: account)
			.environmentObject(AccountViewModel(account: account))
	}
}
