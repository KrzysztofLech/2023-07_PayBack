//  DataService.swift
//  Created by Krzysztof Lech on 19/07/2023.

import Combine
import Foundation
import Network

enum DataServiceError: Error {
	case serverError(statusCode: Int?)
	case noDataReceived
	case decodingError
	case noInternet
	case random

	var title: String {
		switch self {
		case .noInternet:
			return AppStrings.Alerts.noInternet
		case .decodingError:
			return AppStrings.Alerts.decodingProblem
		case .random:
			return AppStrings.Alerts.demo
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

	var isConnected: Bool { get }
	var isConnectedPublisher: Published<Bool>.Publisher { get }

	func getDataFromDemoFile(completion: @escaping (Transactions) -> Void)
}

final class DataService: DataServiceProtocol {
	@Published private(set) var isInProgress = false
	var isInProgressPublisher: Published<Bool>.Publisher { $isInProgress }

	@Published private(set) var error: DataServiceError?
	var errorPublisher: Published<DataServiceError?>.Publisher { $error }

	@Published private(set) var isConnected = true
	var isConnectedPublisher: Published<Bool>.Publisher { $isConnected }

	private let session: URLSession
	private let networkMonitor: NWPathMonitor

	init(session: URLSession = .shared, networkMonitor: NWPathMonitor = NWPathMonitor()) {
		self.session = session
		self.networkMonitor = networkMonitor

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

	func getDataFromDemoFile(completion: @escaping (Transactions) -> Void) {
		guard isConnected else {
			error = .noInternet
			return
		}

		// Random error
		guard Bool.random() else {
			error = .random
			return
		}

		let path = Bundle.main.path(forResource: "PBTransactions", ofType: "json")!
		let url = URL(fileURLWithPath: path)

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601

		isInProgress = true

		guard let data = try? Data(contentsOf: url) else {
			error = .noDataReceived
			return
		}

		guard let transactions = try? decoder.decode(Transactions.self, from: data) else {
			self.error = .decodingError
			return
		}

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.isInProgress = false
			completion(transactions)
		}
	}
}
