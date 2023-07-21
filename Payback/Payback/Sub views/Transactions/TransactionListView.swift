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

				VStack(alignment: .center, spacing: 0) {
					// Filter
					if viewModel.isFilteringOn {
						FilterView(
							categories: viewModel.allCategories,
							selectedCategory: $viewModel.selectedCategory
						)
					}

					// List
					ScrollView(.vertical, showsIndicators: true) {
						if viewModel.isFilteringOn {
							transactionListDividedByCategory
						} else {
							transactionList
						}
					}
				}.animation(.easeIn, value: viewModel.isFilteringOn)
			}
			.modifier(
				NavigationBarModifier(
					title: "World of PAYBACK",
					titleColor: .appWhite,
					backgroundColor: .appPrimary,
					leadingButton: viewModel.leadingButton,
					trailingButton: viewModel.trailingButton
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

	@ViewBuilder
	private var transactionListDividedByCategory: some View {
		LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
			ForEach(viewModel.categories, id: \.self) { category in
				Section(header: getCategoryHeader(category: category)) {
					ForEach(viewModel.getTransactions(forCategory: category)) { transaction in
						coordinator.getTransactionView(forTransaction: transaction)
							.padding(.bottom, 16)
					}
				}
			}
		}
	}

	@ViewBuilder
	private func getCategoryHeader(category: Int) -> some View {
		HStack(spacing: 2) {
			Text("Category:")
			Text(String(category)).fontWeight(.bold)
			Spacer()
		}
		.padding(16)
		.background(Color.white)
	}

	@ViewBuilder
	private var transactionList: some View {
		LazyVStack(spacing: 16) {
			ForEach(viewModel.sortedTransactions) { transaction in
				coordinator.getTransactionView(forTransaction: transaction)
			}
		}
		.padding(.vertical, 16)
	}
}

#Preview {
	TransactionListView(
		coordinator: TransactionListCoordinator(),
		viewModel: TransactionListViewModel(dataService: DataService())
	)
}
