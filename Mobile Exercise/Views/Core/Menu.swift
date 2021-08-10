//
//  Menu.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/6/21.
//

import SwiftUI

struct Menu: View {

	@AppStorage("currentPage") var currentPage: Module = .accounts
	@AppStorage("authUser") var authenticatedUser: String = ""

	@Binding var menuOpen: Bool

	var body: some View {
		ZStack {
			Color("Midnight Green").opacity(0.2)

			HStack {
				NavigationView {
					List {
						Button("Accounts") {
							navigate(to: .accounts)
						}
						.foregroundColor(Color.white)
						.listRowBackground(Color("Dark Purple"))

						Button("Settings") {
							navigate(to: .settings)
						}
						.foregroundColor(Color.white)
						.listRowBackground(Color("Dark Green"))
					}
					.navigationBarTitleDisplayMode(.inline)
					.navigationTitle("Menu")
					.toolbar {
						ToolbarItem(placement: .confirmationAction)
						{
							Button(action: {
								menuOpen.toggle()
							}, label: {
								Image(systemName: "arrowshape.turn.up.right")
									.foregroundColor(Color("Dark Purple"))
							})
						}
					}
				}

				Spacer(minLength: 150.0)
			}
		}
	}

	func navigate(to module:Module) {
		if currentPage != module {
			currentPage = module
		}
		menuOpen = false
	}
}

struct Menu_Previews: PreviewProvider {
	static var previews: some View {
		Menu(menuOpen: .constant(true))
	}
}
