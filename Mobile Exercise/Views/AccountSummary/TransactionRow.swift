//
//  TransactionRow.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/8/21.
//

import SwiftUI

struct TransactionRow: View {

	var transaction: Transaction

	var body: some View {
		HStack {
			Text(transaction.title)
				.fontWeight(.bold)
				.padding([.top, .leading], 8.0)
				.padding(.bottom, 50.0)

			Spacer()

			// Truncate to 2 digits in decimal
			Text(String(format: "$%.2f", transaction.balance))
		}
	}
}

struct TransactionRow_Previews: PreviewProvider {
	static var previews: some View {
		TransactionRow(transaction: Transaction(id: "1", title: "Cafe Rio", balance: -12.56))
			.previewLayout(.fixed(width: 300, height: 70))
	}
}
