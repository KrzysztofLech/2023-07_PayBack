//  TransactionListViewModel.swift
//  Created by Krzysztof Lech on 19/07/2023.

import Combine
import SwiftUI

final class TransactionListViewModel: ObservableObject {
	typealias CategoryTransactions = (category: Int, transactions: [TransactionViewModel])

	private let dataService: DataServiceProtocol?
	private var cancellables = Set<AnyCancellable>()

	init(dataService: DataServiceProtocol? = nil) {
		self.dataService = dataService
	}

	@Published var isFilteringOn = false
	@Published var selectedCategory: Int? = nil

	// MARK: - Navigation bar buttons

	lazy var leadingButton = NavigationBarButton(
		buttonIcon: "arrow.triangle.2.circlepath.circle",
		buttonColor: .appWhite,
		buttonAction: {
			self.transactions.removeAll()
			self.isFilteringOn = false
			self.selectedCategory = nil
			self.getData()
		}
	)

	lazy var trailingButton = NavigationBarButton(
		buttonIcon: "line.3.horizontal.decrease.circle.fill",
		buttonColor: .appWhite,
		buttonAction: {
			self.isFilteringOn.toggle()
			if !self.isFilteringOn {
				self.selectedCategory = nil
			}
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
		allCategories.forEach { category in
			let transactions = sortedTransactions.filter { $0.transaction.category == category }
			array.append((category, transactions))
		}
		return array
	}

	var allCategories: [Int] {
		let categoriesSet = Set<Int>(sortedTransactions.map { $0.transaction.category })
		return Array<Int>(categoriesSet).sorted(by: <)
	}

	var categories: [Int] {
		if let selectedCategory {
			return allCategories.filter { $0 == selectedCategory }
		} else {
			return allCategories
		}
	}

	func getTransactions(forCategory category: Int) -> [TransactionViewModel] {
		let item = categoriesTransactions.first(where: { $0.category == category })
		return item?.transactions ?? []
	}

	func getData() {
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

	func getTotalValue(forCategory category: Int) -> (value: Int, currency: String) {
		let categoryTransactions = getTransactions(forCategory: category)
		let totalValue = categoryTransactions
			.map { $0.valueAmount }
			.reduce(0,+)
		let currency = categoryTransactions.first?.valueCurrency ?? ""
		return (totalValue, currency)
	}
}
