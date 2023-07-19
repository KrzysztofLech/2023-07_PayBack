//  TransactionsView.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct TransactionsView: View {
	@StateObject var viewModel: TransactionsViewModel

	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()

			List(viewModel.listItems, id: \.self) { item in
				NavigationLink(
					value: item,
					label: {
						Text(item.title)
					}
				)
			}
		}
		.onAppear {
			viewModel.getData()
		}
	}
}

#Preview {
	TransactionsView(
		viewModel: TransactionsViewModel(dataService: DataService())
	)
}
