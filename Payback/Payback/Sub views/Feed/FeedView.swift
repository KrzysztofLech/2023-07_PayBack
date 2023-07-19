//  FeedView.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct FeedView: View {
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()

            Text("Feed")
                .font(.headline)
        }
    }
}

#Preview {
	FeedView()
}
