//
//  Login.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/3/21.
//

import SwiftUI

struct Login: View {

	var userAuth: UserAuthViewModel = UserAuthViewModel.shared

	@State private var username: String = ""
	@State private var password: String = ""

	@State private var isActive = false
	@State private var loading: Bool = false
	@State private var loginFailed: Bool = false

	@AppStorage("authUser") var authenticatedUser: String = ""

	var body: some View {

		ZStack {
			Color("Dark Green").ignoresSafeArea()

			VStack {
				Spacer()

				Text("The Basic Bank")
					.font(.largeTitle)
					.fontWeight(.bold)
					.foregroundColor(Color.white)

				Text("We make life simple!")
					.font(.headline)
					.foregroundColor(Color("Baby Blue"))

				Divider()
					.frame(height: 2.0)
					.background(Color("Baby Blue"))
					.padding(.bottom, 50.0)

				TextField("Username", text: $username)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.foregroundColor(Color("Dark Green"))
					.disableAutocorrection(true)
					.autocapitalization(.none)

				SecureField("Password", text: $password)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.foregroundColor(Color("Dark Green"))
					.disableAutocorrection(true)
					.autocapitalization(.none)
					.padding(.bottom, loginFailed ? 0.0 : 50.5)

				if loginFailed {
					Text("Login Failed. Please try again or call support")
						.fontWeight(.bold)
						.multilineTextAlignment(.center)
						.foregroundColor(Color.red)
				}

				Button(action: {
					loading = true

					userAuth.login(username: username, password: password) { authenticated in
						// UI Delay to avoid jarring flashing for quick requests
						DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
							switch authenticated {
								case .success(let user):
									self.authenticatedUser = user.toString()
								case .failure(let error):
									loginFailed = true
									print(error.localizedDescription)
							}

							loading = false
						}
					}
				},
				label: {
					Text("Login")
						.fontWeight(.bold)
				})
				.buttonStyle(PurpleButton())
				.disabled(username.isEmpty || password.isEmpty)

				Spacer()
			}
			.padding(40.0)

			if loading {
				VStack {
					Text("Loading...")
						.foregroundColor(Color("Midnight Green"))
						.fontWeight(.bold)
						.padding(.bottom)

					ProgressView()
						.progressViewStyle(CircularProgressViewStyle())
				}
				.padding(30.0)
				.background(Color("Baby Blue"))
				.cornerRadius(15.0)
			}
		}
	}
}

struct LoginController_Previews: PreviewProvider {
	static var previews: some View {
		Login()
			.previewDevice("iPhone 12 Pro")
	}
}

