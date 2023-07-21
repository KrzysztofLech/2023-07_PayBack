//  TransactionListViewModel.swift
//  Created by Krzysztof Lech on 19/07/2023.

import Combine
import SwiftUI

final class TransactionListViewModel: ObservableObject {
	typealias CategoryTransactions = (category: Int, transactions: [TransactionViewModel])

	private let dataService: DataService?
	private var cancellables = Set<AnyCancellable>()

	init(dataService: DataService? = nil) {
		self.dataService = dataService
	}

	@Published var dividedByCategory = false

	// MARK: - Navigation bar buttons

	lazy var leadingButton = NavigationBarButton(
		buttonIcon: "arrow.up.arrow.down.square.fill",
		buttonColor: .appWhite,
		buttonAction: {
			self.dividedByCategory.toggle()
		}
	)

	// MARK: - Data

	@Published private var transactions: [TransactionViewModel] = []

	var sortedTransactions: [TransactionViewModel] {
		transactions
			.sorted { $0.transaction.transactionDetail.bookingDate > $1.transaction.transactionDetail.bookingDate }
	}

	private var categoriesTransactions: [CategoryTransactions] {
		var array: [CategoryTransactions] = []
		categories.forEach { category in
			let transactions = sortedTransactions.filter { $0.transaction.category == category }
			array.append((category, transactions))
		}
		return array
	}

	var categories: [Int] {
		let categoriesSet = Set<Int>(sortedTransactions.map { $0.transaction.category })
		return Array<Int>(categoriesSet).sorted(by: <)
	}

	func getTransactions(forCategory category: Int) -> [TransactionViewModel] {
		let item = categoriesTransactions.first(where: { $0.category == category })
		return item?.transactions ?? []
	}

	func getData() {
		// Commented to refresh data on every appear
		// guard transactions.isEmpty else { return }

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
