//
//  Transaction.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/4/21.
//

import Foundation

struct Transaction: Hashable, Codable, Identifiable {

	var id: String

	var title: String
	var balance: Double

	var formattedBalance: String { String(format: "$%.2f", balance) }
}
