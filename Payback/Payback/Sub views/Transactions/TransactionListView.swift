//  TransactionListView.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct TransactionListView: View {
	@StateObject var coordinator: TransactionListCoordinator
	@StateObject var viewModel: TransactionListViewModel

	var body: some View {
		NavigationStack(path: $coordinator.path) {
			ZStack {
				Color.white

				ScrollView(.vertical, showsIndicators: true) {
					LazyVStack(alignment: .leading, spacing: 0) {
						ForEach(viewModel.transactions) { transaction in
							coordinator.getTransactionView(forTransaction: transaction)
						}
					}.padding(.bottom, 16)
				}
			}
			.modifier(
				NavigationBarModifier(
					title: "World of PAYBACK",
					titleColor: .appWhite,
					backgroundColor: .appPrimary
				)
			)
			.navigationDestination(for: TransactionViewModel.self) { transaction in
				coordinator.getTransactionDetailsView(forTransaction: transaction)
			}
		}
		.onAppear {
			viewModel.getData()
		}
	}
}

#Preview {
	TransactionListView(
		coordinator: TransactionListCoordinator(),
		viewModel: TransactionListViewModel(dataService: DataService())
	)
}
