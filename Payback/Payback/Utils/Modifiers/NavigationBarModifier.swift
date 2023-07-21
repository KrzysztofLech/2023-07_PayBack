//  NavigationBarModifier.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct NavigationBarButton {
	let buttonIcon: String
	let buttonColor: Color
	let buttonAction: () -> Void
}

struct NavigationBarModifier: ViewModifier {
	let title: String
	let titleColor: Color
	let backgroundColor: Color
	var leadingButton: NavigationBarButton? = nil
	var trailingButton: NavigationBarButton? = nil

	func body(content: Content) -> some View {
		content
			.toolbar {
				if let leadingButton {
					ToolbarItem(placement: .topBarLeading) {
						Button(
							action: leadingButton.buttonAction,
							label: {
								Image(systemName: leadingButton.buttonIcon)
									.frame(width: 50, height: 44)
							}
						)
						.tint(leadingButton.buttonColor)
					}
				}

				if let trailingButton {
					ToolbarItem(placement: .topBarTrailing) {
						Button(
							action: trailingButton.buttonAction,
							label: {
								Image(systemName: trailingButton.buttonIcon)
									.frame(width: 50, height: 44)
							}
						)
						.tint(trailingButton.buttonColor)
					}
				}

				ToolbarItem(placement: .principal) {
					Text(title)
						.foregroundStyle(titleColor)
				}
			}

			.toolbar(.visible, for: .navigationBar)
			.toolbarBackground(.visible, for: .navigationBar)
			.toolbarBackground(backgroundColor, for: .navigationBar)

			.navigationBarTitleDisplayMode(.inline)
	}
}
