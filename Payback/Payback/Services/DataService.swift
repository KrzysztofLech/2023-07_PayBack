//  DataService.swift
//  Created by Krzysztof Lech on 19/07/2023.

import Combine
import Foundation
import Network

enum DataServiceError: Error {
	case serverError(statusCode: Int?)
	case noDataReceived
	case decodingError
	case unknownError(Error)
	case noInternet

	var title: String {
		switch self {
		case .noInternet:
			return "No Internet!"
		case .unknownError:
			return "Unknown error!"
		case .decodingError:
			return "Decoding problem!"
		default:
			return self.localizedDescription
		}
	}
}

protocol DataServiceProtocol {
	var isInProgress: Bool { get }
	var isInProgressPublisher: Published<Bool>.Publisher { get }
	var error: DataServiceError? { get }
	var errorPublisher: Published<DataServiceError?>.Publisher { get }

	func getDataFromDemoFile(completion: @escaping (Transactions?) -> Void)
}

final class DataService: DataServiceProtocol {
	@Published private(set) var isInProgress = false
	var isInProgressPublisher: Published<Bool>.Publisher { $isInProgress }

	@Published private(set) var error: DataServiceError?
	var errorPublisher: Published<DataServiceError?>.Publisher { $error }

	private let networkMonitor = NWPathMonitor()
	private var isConnected = true

	private let session: URLSession

	init(session: URLSession = .shared) {
		self.session = session
		startNetworkMonitoring()
	}

	deinit {
		stopNetworkMonitoring()
	}

	// MARK: - Network Reachability

	private func startNetworkMonitoring() {
		networkMonitor.start(queue: .global())
		networkMonitor.pathUpdateHandler = { [weak self] path in
			self?.isConnected = path.status == .satisfied
		}
	}

	private func stopNetworkMonitoring() {
		networkMonitor.cancel()
	}

	// MARK: - Data requests

	func getDataFromDemoFile(completion: @escaping (Transactions?) -> Void) {
		guard isConnected else {
			error = .noInternet
			completion(nil)
			return
		}

		let path = Bundle.main.path(forResource: "PBTransactions", ofType: "json")!
		let url = URL(fileURLWithPath: path)

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601

		isInProgress = true

		guard let data = try? Data(contentsOf: url) else {
			error = .noDataReceived
			completion(nil)
			return
		}

		guard let transactions = try? decoder.decode(Transactions.self, from: data) else {
			self.error = .decodingError
			completion(nil)
			return
		}

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.isInProgress = false
			completion(transactions)
		}
	}
}
