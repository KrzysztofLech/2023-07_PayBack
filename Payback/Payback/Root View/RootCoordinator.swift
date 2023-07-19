//  RootCoordinator.swift
//  Created by Krzysztof Lech on 19/07/2023.

import Combine
import SwiftUI

enum AppFlowItem: Hashable {
	case cover
	case mainScreen
}

enum FullScreenItem {
	case loader
	case alert(String)
}

enum ModalViewItem: Int, Identifiable {
	case test

	var id: Int { rawValue }
}

final class RootCoordinator: ObservableObject {
	@Published var appFlow: AppFlowItem = .cover
	@Published var fullScreenItem: FullScreenItem?
	@Published var modalViewItem: ModalViewItem?

	private var cancellables = Set<AnyCancellable>()
	let dataService: DataService

	init(dataService: DataService = DataService()) {
		self.dataService = dataService

		connectWithDataService()

//		DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//			self.modalViewItem = .test
//		}

//		DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
//			self.fullScreenItem = .alert("Test Alert!")
//		}
	}

	private func connectWithDataService() {
		dataService.$isInProgress
			.sink { isInProgress in
				self.fullScreenItem = isInProgress ? .loader : nil
			}
			.store(in: &cancellables)

		dataService.$error
			.sink { error in
				if let error {
					self.fullScreenItem = .alert(error.title)
				}
			}
			.store(in: &cancellables)
	}

	// MARK: - Primary views: cover, mainScreen ...

	@ViewBuilder
	var appFlowView: some View {
		switch appFlow {
		case .cover:
			getCoverView()

		case .mainScreen:
			getMainScreenView()
		}
	}

	// Cover
	private func getCoverView() -> some View {
		CoverView {
			self.appFlow = .mainScreen
		}
	}

	// MainScreen
	private func getMainScreenView() -> some View {
		let viewModel = MainViewModel()
		return MainView(
			coordinator: MainViewCoordinator(rootCoordinator: self),
			viewModel: viewModel
		)
	}

	// MARK: - Full-screen views: alerts, popups, loader ...

	@ViewBuilder
	var fullScreenViewIfNeeded: some View {
		if let fullScreenItem {
			switch fullScreenItem {
			case .loader:
				LoaderView()

			case .alert(let text):
				AlertView(text: text) {
					self.fullScreenItem = nil
				}
			}
		}
	}

	// MARK: - Modal views

	@ViewBuilder
	func getView(for item: ModalViewItem) -> some View {
		switch item {
		case .test:
			Text("Modal test")
		}
	}
}
