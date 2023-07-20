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
			let viewModel = TransactionsViewModel(dataService: rootCoordinator.dataService)
			NavigationStack {
				TransactionsView(viewModel: viewModel)
				.navigationDestination(for: Transaction.self) { item in
					self.getSubview(for: item)
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
	private func getSubview(for item: Transaction) -> some View {
		Text(item.partnerDisplayName)
			.modifier(
				NavigationBarModifier(
					title: item.partnerDisplayName,
					titleColor: .appWhite,
					backgroundColor: .appPrimary
				)
			)
	}
}
