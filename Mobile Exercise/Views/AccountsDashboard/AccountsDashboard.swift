//
//  AccountsDashboard.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/4/21.
//

import SwiftUI

struct AccountsDashboard: View {

	@EnvironmentObject var accountsViewModel: AccountsViewModel

	@State var menuOpen = false

	var body: some View {
		ZStack {
			NavigationView {
				List {
					ForEach(accountsViewModel.accounts) { account in
						NavigationLink(
							destination: AccountSummary(account: account)
								.environmentObject(AccountViewModel(account: account))
						) {
							AccountRow(account: account)
						}
					}
				}
				.navigationBarTitleDisplayMode(.inline)
				.navigationTitle("Welcome")
				.toolbar {
					ToolbarItem(placement: .cancellationAction) {
						Button(action: {
							menuOpen.toggle()
						}, label: {
							Image(systemName: "list.bullet")
						})
					}
				}
			}
			if menuOpen {
				Menu(menuOpen: $menuOpen)
			}
		}
	}
}

struct AccountsDashboard_Previews: PreviewProvider {
	static var previews: some View {
		AccountsDashboard()
			.environmentObject(AccountsViewModel())
	}
}
