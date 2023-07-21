//  FilterView.swift
//  Created by Krzysztof Lech on 21/07/2023.

import SwiftUI

struct FilterView: View {
	let categories: [Int]
	@Binding var selectedCategory: Int?

    var body: some View {
		ZStack {
			Color.appPrimary

			ScrollView(.horizontal, showsIndicators: false) {
				HStack(alignment: .center, spacing: 0) {
					ForEach(Array(categories.enumerated()), id: \.offset) { index, category in
						Button(
							action: {
								if selectedCategory == category {
									selectedCategory = nil
								} else {
									selectedCategory = category
								}
							},
							label: {
								Text("Category \(category)")
									.padding(8)
									.foregroundStyle(Color.appPrimary)
									.background(
										category == selectedCategory ? Color.appOrange : Color.appBackground,
										in: RoundedRectangle(cornerRadius: 4)
									).animation(.default, value: selectedCategory)
									.padding(.leading, 16)
									.padding(.trailing, categories.count == (index + 1) ? 16 : 0)
							}
						)
					}
				}
			}
		}
		.frame(height: 60)
    }
}

struct FilterView_Previews: PreviewProvider {
	@State private static var selectedCategory: Int? = 2

	static var previews: some View {
		FilterView(
			categories: [1, 2, 3],
			selectedCategory: $selectedCategory
		)
			.previewLayout(.sizeThatFits)
	}
}
