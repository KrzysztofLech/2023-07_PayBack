//  MainView.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct MainView: View {
	@StateObject var coordinator: MainViewCoordinator
	@StateObject var viewModel: MainViewModel

    var body: some View {
		TabView(selection: $viewModel.tabIndex) {
			Group {
				ForEach(MainScreenTabViewItem.allCases) { item in
					coordinator.getView(for: item)
				}
			}
			.modifier(TabBarModifier())
		}
		.accentColor(.appWhite)
    }
}

#Preview {
    MainView(
		coordinator: MainViewCoordinator(rootCoordinator: RootCoordinator()),
		viewModel: MainViewModel()
	)
}
