//  MainScreenTabViewItem.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

enum MainScreenTabViewItem: Int {
	case transactions, feed, shopping, settings

	@ViewBuilder
	var tabItem: some View {
		switch self {
		case .transactions:
			Label("Transactions", systemImage: "list.bullet")
		case .feed:
			Label("Feed", systemImage: "globe")
		case .shopping:
			Label("Shopping", systemImage: "cart.fill")
		case .settings:
			Label("Settings", systemImage: "gearshape.fill")
		}
	}
}
