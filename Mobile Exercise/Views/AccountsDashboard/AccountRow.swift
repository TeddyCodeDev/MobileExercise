//
//  AccountRow.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/4/21.
//

import SwiftUI

struct AccountRow: View {

	var account: Account

	var body: some View {
		HStack {
			Text(account.name)
				.fontWeight(.bold)
				.padding([.top, .leading], 8.0)
				.padding(.bottom, 50.0)

			Spacer()

			// Truncate to 2 digits in decimal
			Text(account.formattedBalance)
		}
	}
}

struct AccountRow_Previews: PreviewProvider {
	static var previews: some View {
		AccountRow(account: Account(id: "1", name: "Test Account", balance: 2542.21))
			.previewLayout(.fixed(width: 300, height: 70))
	}
}
