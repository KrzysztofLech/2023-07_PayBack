//  TransactionsItem.swift
//  Created by Krzysztof Lech on 19/07/2023.

import Foundation

struct TransactionsItem: Hashable {
	let title: String
}

extension TransactionsItem {
	static var demoData: [TransactionsItem] {
		return [
			.init(title: "First transaction"),
			.init(title: "Second transaction"),
			.init(title: "Third transaction")
		]
	}
}
