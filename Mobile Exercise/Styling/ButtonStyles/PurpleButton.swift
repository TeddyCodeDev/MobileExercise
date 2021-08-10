//
//  PurpleButton.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/3/21.
//

import SwiftUI

struct PurpleButton: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		EmbeddedButton(configuration: configuration)
	}

	struct EmbeddedButton: View {
		let configuration: ButtonStyle.Configuration
		@Environment(\.isEnabled) private var isEnabled: Bool
		var body: some View {
			configuration.label
				.padding(.horizontal, 40.0)
				.padding(.vertical, 12.0)
				.foregroundColor(isEnabled ? .white : .black)
				.background(isEnabled ? Color("Dark Purple") : Color.gray)
				.cornerRadius(20.0)
		}
	}
}
