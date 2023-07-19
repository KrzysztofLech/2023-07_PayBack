//  CoverView.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct CoverView: View {
	let didFinishAction: (() -> Void)?

    var body: some View {
		ZStack {
			Color.yellow.ignoresSafeArea()
			Text("COVER")
		}
		.onAppear(delay: 1) {
			didFinishAction?()
		}
    }
}

#Preview {
    CoverView(didFinishAction: nil)
}
