//  TransactionListViewModel.swift
//  Created by Krzysztof Lech on 19/07/2023.

import Combine
import Foundation

final class TransactionListViewModel: ObservableObject {
	private let dataService: DataService?
	private var cancellables = Set<AnyCancellable>()

	init(dataService: DataService? = nil) {
		self.dataService = dataService
	}

	@Published private var transactions: [TransactionViewModel] = []

	var sortedTransactions: [TransactionViewModel] {
		transactions
			.sorted { $0.transaction.transactionDetail.bookingDate > $1.transaction.transactionDetail.bookingDate }
	}

	func getData() {
		// Commented to refresh data on every appear
		guard transactions.isEmpty else { return }

		dataService?.getDataFromDemoFile()
			.sink(
				receiveCompletion: {_ in},
				receiveValue: { value in
					let data = value.items.map { TransactionViewModel(transaction: $0) }
					self.transactions = data
				}
			)
			.store(in: &cancellables)
	}
}
