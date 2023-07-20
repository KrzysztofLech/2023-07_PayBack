//  TransactionListView.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

struct TransactionListView: View {
	@StateObject var viewModel: TransactionListViewModel

	var body: some View {
		ZStack {
			Color.white.ignoresSafeArea()

			List(viewModel.transactions, id: \.self) { transaction in
				TransactionView(transaction: transaction)
					.listRowSeparator(.hidden)
			}
			.listStyle(.plain)
		}
		.onAppear {
			viewModel.getData()
		}
	}
}

#Preview {
	TransactionListView(
		viewModel: TransactionListViewModel(dataService: DataService())
	)
}
