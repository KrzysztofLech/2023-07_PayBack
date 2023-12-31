//  NotificationsView.swift
//  Created by Krzysztof Lech on 19/07/2023.


import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color.teal.ignoresSafeArea()

			Text(AppStrings.Settings.title)
                .font(.headline)
        }
    }
}

#Preview {
	SettingsView()
}
