//
//  Settings.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/8/21.
//

import SwiftUI

struct Settings: View {

	@AppStorage("authUser") var authenticatedUser: String = ""

	@State var menuOpen = false
	
	var body: some View {
		ZStack {
			VStack {
				Spacer()

				Button(action: {
					menuOpen.toggle()
				}, label: {
					Text("Menu")
						.fontWeight(.bold)
				})
				.buttonStyle(PurpleButton())

				Spacer()

				Button(action: {
					authenticatedUser = ""
				}, label: {
					Text("Logout")
						.fontWeight(.bold)
				})
				.buttonStyle(PurpleButton())

				Spacer()
			}
			.navigationBarTitleDisplayMode(.inline)
			.navigationTitle("Settings")
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button(action: {
						menuOpen.toggle()
					}, label: {
						Image(systemName: "list.bullet")
					})
				}
			}

			if menuOpen {
				Menu(menuOpen: $menuOpen)
			}
		}
	}
}

struct SettingsController_Previews: PreviewProvider {
	static var previews: some View {
		Settings()
	}
}
