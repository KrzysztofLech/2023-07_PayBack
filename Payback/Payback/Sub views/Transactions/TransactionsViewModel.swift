//  TransactionsViewModel.swift
//  Created by Krzysztof Lech on 19/07/2023.

import Combine
import Foundation

final class TransactionsViewModel: ObservableObject {
	private let dataService: DataService?
	private var cancellables = Set<AnyCancellable>()

	init(dataService: DataService? = nil) {
		self.dataService = dataService
	}

	@Published var listItems: [TransactionsItem] = []

	func getData() {
		guard listItems.isEmpty else { return }
		
		dataService?.getTransactions()
			.sink { data in
				self.listItems = data
			}
			.store(in: &cancellables)
	}
}
