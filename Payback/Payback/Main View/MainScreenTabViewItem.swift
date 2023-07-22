//  MainScreenTabViewItem.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

enum MainScreenTabViewItem: Int, CaseIterable, Identifiable {
	case transactions, feed, shopping, settings

	var id: Int {
		self.rawValue
	}

	@ViewBuilder
	var tabItem: some View {
		switch self {
		case .transactions:
			Label(
				AppStrings.MainScreen.TabItem.transactions,
				systemImage: "list.bullet"
			)

		case .feed:
			Label(
				AppStrings.MainScreen.TabItem.feed,
				systemImage: "globe"
			)

		case .shopping:
			Label(
				AppStrings.MainScreen.TabItem.shopping,
				systemImage: "cart.fill"
			)

		case .settings:
			Label(
				AppStrings.MainScreen.TabItem.settings,
				systemImage: "gearshape.fill"
			)
		}
	}
}
