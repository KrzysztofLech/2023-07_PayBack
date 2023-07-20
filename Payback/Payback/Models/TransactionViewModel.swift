//  TransactionViewModel.swift
//  Created by Krzysztof Lech on 20/07/2023.

import Foundation

struct TransactionViewModel {
	let transaction: Transaction

	var date: String {
		let date = transaction.transactionDetail.bookingDate
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		return formatter.string(from: date)
	}

	var partner: String {
		transaction.partnerDisplayName
	}

	var description: String? {
		transaction.transactionDetail.description
	}

	var valueAmount: Int {
		transaction.transactionDetail.value.amount
	}

	var valueCurrency: String {
		transaction.transactionDetail.value.currency
	}
}

extension TransactionViewModel: Identifiable {
	var id: String {
		transaction.alias.reference
	}
}

extension TransactionViewModel: Hashable {
	static func == (lhs: TransactionViewModel, rhs: TransactionViewModel) -> Bool {
		lhs.transaction.alias.reference == rhs.transaction.alias.reference
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(transaction.alias.reference)
	}
}

extension TransactionViewModel {
	static let preview: TransactionViewModel = TransactionViewModel(
		transaction: Transaction(
			alias: TransactionAlias(reference: "795357452000810"),
			category: 1,
			partnerDisplayName: "REWE Group",
			transactionDetail: TransactionDetail(
				bookingDate: Date(),
				description: "Punkte sammeln",
				value: TransactionValue(
					amount: 124,
					currency: "PBP"
				)
			)
		)
	)
}
