//
//  Account.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/4/21.
//

import Foundation

struct Account: Hashable, Codable, Identifiable {

	var id: String
	var name: String
	var balance: Double

	var formattedBalance: String { String(format: "$%.2f", balance) }
}
