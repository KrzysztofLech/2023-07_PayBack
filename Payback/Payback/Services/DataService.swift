//  DataService.swift
//  Created by Krzysztof Lech on 19/07/2023.

import Combine
import Foundation

enum DataServiceError: Error {
	case serverError(statusCode: Int?)
	case noDataReceived
	case decodingError(DecodingError)
	case unknownError(Error)

	var title: String {
		switch self {
		case .unknownError:
			return "Unknown error!"
		default: return ""
		}
	}
}

final class DataService: ObservableObject {
	@Published var isInProgress = false
	@Published var error: DataServiceError?

	private let session: URLSession

	init(session: URLSession = .shared) {
		self.session = session
	}

	func getDataFromDemoFile() -> AnyPublisher<Transactions, Error> {
		let path = Bundle.main.path(forResource: "PBTransactions", ofType: "json")!
		let url = URL(fileURLWithPath: path)

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601

		isInProgress = true
		return self.session
			.dataTaskPublisher(for: url)
			.delay(for: 1, scheduler: RunLoop.main)
			.tryMap { data, response in
				self.isInProgress = false
				return data
			}
			.decode(type: Transactions.self, decoder: decoder)
			.eraseToAnyPublisher()
	}
}
