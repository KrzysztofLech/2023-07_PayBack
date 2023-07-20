//  Transactions.swift
//  Created by Krzysztof Lech on 19/07/2023.

import Foundation

struct Transactions: Decodable {
	let items: [Transaction]
}

struct Transaction: Decodable {
	let alias: TransactionAlias
	let category: Int
	let partnerDisplayName: String
	let transactionDetail: TransactionDetail
}

struct TransactionAlias: Decodable {
	let reference: String
}

struct TransactionDetail: Decodable {
	let bookingDate: Date
	let description: String?
	let value: TransactionValue
}

struct TransactionValue: Decodable {
	let amount: Int
	let currency: String
}
