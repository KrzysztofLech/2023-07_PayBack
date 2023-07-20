//  TransactionListCoordinator.swift
//  Created by Krzysztof Lech on 20/07/2023.

import Combine
import SwiftUI

final class TransactionListCoordinator: ObservableObject {
	@Published var path = NavigationPath()
	private var cancellables = Set<AnyCancellable>()

	func getTransactionView(forTransaction transaction: TransactionViewModel) -> some View {
		let view = TransactionView(transaction: transaction)
		view.didSelect
			.sink { transaction in
				self.path.append(transaction)
			}
			.store(in: &cancellables)
		return view
	}

	@ViewBuilder
	func getTransactionDetailsView(forTransaction transaction: TransactionViewModel) -> some View {
		TransactionDetailsView(transaction: transaction)
			.modifier(
				NavigationBarModifier(
					title: "Transaction details",
					titleColor: .appWhite,
					backgroundColor: .appPrimary
				)
			)
	}
}
