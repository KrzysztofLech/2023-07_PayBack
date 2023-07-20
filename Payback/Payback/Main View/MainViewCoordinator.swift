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
			let coordinator = TransactionListCoordinator()
			let viewModel = TransactionListViewModel(dataService: rootCoordinator.dataService)
			TransactionListView(
				coordinator: coordinator,
				viewModel: viewModel
			)
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
}
