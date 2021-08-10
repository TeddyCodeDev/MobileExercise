//
//  Main.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/6/21.
//

import SwiftUI

enum Module: Int {
	case accounts = 0
	case settings
}

struct Main: View {
	@AppStorage("currentPage") var currentPage: Module = .accounts
	@AppStorage("authUser") var authenticatedUser: String = ""

	var body: some View {

		if authenticatedUser == "" {
			Login()
		}
		else {
			switch currentPage {
				case .accounts:
					AccountsDashboard()
						.environmentObject(AccountsViewModel())
				case .settings:
					Settings()
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
