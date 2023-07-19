//  AlertView.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct AlertView: View {
	let text: String
	let didFinishAction: (() -> Void)?

    var body: some View {
		ZStack {
			Color.black.opacity(0.4).ignoresSafeArea()

			VStack(alignment: .center) {
				Text(text)
					.font(.system(size: 18))
					.foregroundStyle(.white)
					.padding(32)
					.background(.red, in: RoundedRectangle(cornerRadius: 16))
			}
		}
		.onAppear(delay: 2) {
			didFinishAction?()
		}
    }
}

#Preview {
    AlertView(
		text: "ALERT !!!",
		didFinishAction: nil
	)
}
