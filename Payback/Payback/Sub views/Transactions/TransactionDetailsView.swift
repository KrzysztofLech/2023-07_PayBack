//  TransactionDetailsView.swift
//  Created by Krzysztof Lech on 20/07/2023.

import SwiftUI

struct TransactionDetailsView: View {
	let transaction: TransactionViewModel

    var body: some View {
		ZStack(alignment: .leading) {
			RoundedRectangle(cornerRadius: 8)
				.fill(Color.appBackground)
				.padding(16)

			VStack(alignment: .leading, spacing: 32) {
				partnerInfo
				descriptionInfo

				Spacer()
			}
			.padding(32)
		}
    }

	private var partnerInfo: some View {
		HStack(alignment: .firstTextBaseline, spacing: 8) {
			Text("Partner:")
				.font(.system(size: 12, weight: .light))
			Text(transaction.partner)
				.font(.system(size: 18, weight: .regular))
		}
	}

	private var descriptionInfo: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("Description:")
				.font(.system(size: 12, weight: .light))
			Text(transaction.description ?? "-")
				.font(.system(size: 18, weight: .thin))
		}
	}
}

struct TransactionDetailsView_Previews: PreviewProvider {
	static var previews: some View {
		TransactionDetailsView(transaction: TransactionViewModel.preview)
			.previewLayout(.fixed(width: 320, height: 600))
	}
}
