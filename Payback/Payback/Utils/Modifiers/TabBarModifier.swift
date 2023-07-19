//  TabBarModifier.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct TabBarModifier: ViewModifier {
	let color: Color = .appPrimary

	func body(content: Content) -> some View {
		content
			.toolbar(.visible, for: .tabBar)
			.toolbarBackground(.visible, for: .tabBar)
			.toolbarBackground(color, for: .tabBar)
	}
}
