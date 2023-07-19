//  PaybackApp.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

@main
struct PaybackApp: App {
	let dataService = DataService()

    var body: some Scene {
		WindowGroup {
			let rootCoordinator = RootCoordinator(
				dataService: dataService
			)
			RootView(coordinator: rootCoordinator)
		}
    }
}
