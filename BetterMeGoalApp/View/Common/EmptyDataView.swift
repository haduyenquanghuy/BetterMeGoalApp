//
//  EmptyDataView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 9/7/25.
//

import SwiftUI

struct EmptyDataView: View {
    var title: String = "Không có dữ liệu"
    var message: String? = nil
    var icon: String = "tray" // SF Symbol mặc định

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundColor(.gray.opacity(0.6))

            Text(title)
                .font(.headline)
                .foregroundColor(.gray)

            if let message = message {
                Text(message)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray.opacity(0.8))
                    .padding(.horizontal)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyDataView()
}
