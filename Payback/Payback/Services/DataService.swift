//  DataService.swift
//  Created by Krzysztof Lech on 19/07/2023.

import Combine
import Foundation

enum DataServiceError: Error {
	case unknown

	var title: String {
		switch self {
		case .unknown:
			return "Unknown error!"
		}
	}
}

final class DataService: ObservableObject {
	@Published var isInProgress = false
	@Published var error: DataServiceError?
		
	func getTransactions() -> AnyPublisher<[TransactionsItem], Never> {
		isInProgress = true
		return Just(())
			.delay(for: 1, scheduler: RunLoop.main)
			.map {
				self.isInProgress = false
				return TransactionsItem.demoData
			}
			.eraseToAnyPublisher()
	}
}
