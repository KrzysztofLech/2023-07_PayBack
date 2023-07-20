//  MainViewCoordinator.swift
//  Created by Krzysztof Lech on 19/07/2023.

import Foundation
import SwiftUI

final class MainViewCoordinator: ObservableObject {
	private let rootCoordinator: RootCoordinator

	init(rootCoordinator: RootCoordinator) {
		self.rootCoordinator = rootCoordinator
	}

	@ViewBuilder
	func getView(for item: MainScreenTabViewItem) -> some View {
		switch item {
		case .transactions:
			let viewModel = TransactionListViewModel(dataService: rootCoordinator.dataService)
			NavigationStack {
				TransactionListView(viewModel: viewModel)
				.navigationDestination(for: TransactionViewModel.self) { transaction in
					self.getDetailsView(forTransaction: transaction)
				}
				.modifier(
					NavigationBarModifier(
						title: "World of PAYBACK",
						titleColor: .appWhite,
						backgroundColor: .appPrimary
					)
				)
			}
			.tabItem { item.tabItem }
			.tag(item.rawValue)


		case .feed:
			FeedView()
				.tabItem { item.tabItem }
				.tag(item.rawValue)

		case .shopping:
			ShoppingView()
				.tabItem { item.tabItem }
				.tag(item.rawValue)

		case .settings:
			SettingsView()
				.tabItem { item.tabItem }
				.tag(item.rawValue)
		}
	}

	@ViewBuilder
	private func getDetailsView(forTransaction transaction: TransactionViewModel) -> some View {
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
