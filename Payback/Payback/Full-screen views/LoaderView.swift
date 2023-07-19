//  LoaderView.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct LoaderView: View {
	var body: some View {
		ZStack {
			Color.black
				.opacity(0.2)
				.ignoresSafeArea()

			VisualEffectView(effect: UIBlurEffect(style: .regular))
				.opacity(0.6)
				.ignoresSafeArea()

			ProgressView()
				.padding()
				.background(.white, in: RoundedRectangle(cornerRadius: 10))
		}
	}
}

#Preview {
	LoaderView()
}

struct VisualEffectView: UIViewRepresentable {
	internal var effect: UIVisualEffect?

	internal func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
		UIVisualEffectView()
	}
	internal func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
		uiView.effect = effect
	}
}
