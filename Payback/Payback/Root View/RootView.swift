//  RootView.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct RootView: View {
	@StateObject var coordinator: RootCoordinator

	var body: some View {
		ZStack {
			// Main app's flow views
			coordinator.appFlowView

			// Full-screen views
			coordinator.fullScreenViewIfNeeded
		}

		// Modals
		.sheet(item: $coordinator.modalViewItem) { item in
			coordinator.getView(for: item)
		}
	}
}

#Preview {
	RootView(coordinator: RootCoordinator())
}
