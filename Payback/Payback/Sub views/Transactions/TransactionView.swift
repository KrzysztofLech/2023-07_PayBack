//  TransactionView.swift
//  Created by Krzysztof Lech on 20/07/2023.

import SwiftUI

struct TransactionView: View {
	let transaction: TransactionViewModel

	var body: some View {
		ZStack(alignment: .leading) {
			VStack(alignment: .leading, spacing: 4) {
				HStack(spacing: 8) {
					Text(transaction.partner).font(.system(size: 12, weight: .regular))
					Spacer(minLength: 0)
				}
				Text("transaction.description").font(.system(size: 9, weight: .thin))

				Color.black.opacity(0.2)
					.frame(height: 1)

				HStack(spacing: 0) {
					Text(transaction.valueAmount, format: .currency(code: transaction.valueCurrency))
						.font(.system(size: 10, weight: .medium))

					Spacer(minLength: 8)

					Text(transaction.date).font(.system(size: 10, weight: .thin))
				}
			}
			.padding(16)
			.background {
				RoundedRectangle(cornerRadius: 4)
					.fill(Color.appBackground)
			}

			NavigationLink(
				value: transaction,
				label: { EmptyView() }
			)
			.opacity(0.0)
		}
	}
}

struct TransactionView_Previews: PreviewProvider {
	static var previews: some View {
		TransactionView(transaction: TransactionViewModel.preview)
			.previewLayout(.sizeThatFits)
	}
}
