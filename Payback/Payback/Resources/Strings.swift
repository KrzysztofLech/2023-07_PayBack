//  Strings.swift
//  Created by Krzysztof Lech on 22/07/2023.

import Foundation

enum AppStrings {
	enum Alerts {
		static let noInternet = "No Internet!"
		static let decodingProblem = "Decoding problem!"
		static let demo = "Demo RANDOM error!\nTry again"
	}

	enum FullScreen {
		static let modalTest = "Modal test"
	}

	enum MainScreen {
		enum TabItem {
			static let transactions = "Transactions"
			static let feed = "Feed"
			static let shopping = "Shopping"
			static let settings = "Settings"
		}
	}

	enum Transactions {
		static let title = "World of PAYBACK"
		static let noData = "No transactions"
		static let category = "Category:"
		static let totalValue = "Total Value:"
		static let filterCategory = "Category %d"
	}

	enum TransactionDetails {
		static let title = "Transaction details"
		static let partner = "Partner:"
		static let description = "Description:"
		static let noDescription = "-"
	}
}
