//  MainView.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct MainView: View {
	@StateObject var coordinator: MainViewCoordinator
	@StateObject var viewModel: MainViewModel

    var body: some View {
		TabView(selection: $viewModel.tabIndex) {
			Group {
				coordinator.getView(for: .transactions)
				coordinator.getView(for: .feed)
				coordinator.getView(for: .shopping)
				coordinator.getView(for: .settings)
			}
			.modifier(TabBarModifier())
		}
    }
}

#Preview {
    MainView(
		coordinator: MainViewCoordinator(rootCoordinator: RootCoordinator()),
		viewModel: MainViewModel()
	)
}
