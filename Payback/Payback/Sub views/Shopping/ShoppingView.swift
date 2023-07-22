//  ShoppingView.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct ShoppingView: View {
    var body: some View {
        ZStack {
            Color.pink.ignoresSafeArea()

			Text(AppStrings.Shopping.title)
                .font(.headline)
        }
    }
}

#Preview {
	ShoppingView()
}
