//  NavigationBarModifier.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct NavigationBarModifier: ViewModifier {
	let title: String
	let titleColor: Color
	let backgroundColor: Color

	func body(content: Content) -> some View {
		content
			.toolbar {
				ToolbarItem(placement: .principal) {
					Text(title).foregroundStyle(titleColor)
				}
			}

			.toolbar(.visible, for: .navigationBar)
			.toolbarBackground(.visible, for: .navigationBar)
			.toolbarBackground(backgroundColor, for: .navigationBar)
			.toolbarColorScheme(.dark, for: .navigationBar)

			.navigationBarTitleDisplayMode(.inline)
	}
}
