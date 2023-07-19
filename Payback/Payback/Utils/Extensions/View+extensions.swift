//  View+extensions.swift
//  Created by Krzysztof Lech on 19/07/2023.

import SwiftUI

public extension TimeInterval {
	var nanoseconds: UInt64 {
		return UInt64((self * 1_000_000_000).rounded())
	}
}

public extension View {
	func onAppear(delay: TimeInterval, action: @escaping () -> Void) -> some View {
		task {
			do {
				try await Task.sleep(nanoseconds: delay.nanoseconds)
			} catch {
				return
			}

			await MainActor.run {
				action()
			}
		}
	}
}
