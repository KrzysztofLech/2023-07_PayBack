//  Strings.swift
//  Created by Krzysztof Lech on 22/07/2023.

import Foundation

enum AppStrings {
	enum Alerts {
		static let decodingProblem = "alert_decodingProblem".localized
		static let demo = "alert_demo".localized
		static let noInternet = "alert_noInternet".localized

	}

	enum Modals {
		static let modalTest = "modal_test".localized
	}

	enum TabItem {
		static let transactions = "tabItem_transactions".localized
		static let feed = "tabItem_feed".localized
		static let shopping = "tabItem_shopping".localized
		static let settings = "tabItem_settings".localized
	}

	enum Transactions {
		static let title = "transactions_title".localized
		static let noData = "transactions_noData".localized
		static let category = "transactions_category".localized
		static let totalValue = "transactions_totalValue".localized
		static let filterCategory = "transactions_filter_Category".localized
	}

	enum TransactionDetails {
		static let title = "transactionDetails_title".localized
		static let partner = "transactionDetails_Partner".localized
		static let description = "transactionDetails_description".localized
		static let noDescription = "transactionDetails_noDescription".localized
	}

	enum Feed {
		static let title = "feed_title".localized
	}

	enum Shopping {
		static let title = "shopping_title".localized
	}

	enum Settings {
		static let title = "settings_title".localized
	}
}

extension String {
	var localized: String {
		return NSLocalizedString(self, comment: "")
	}
}
