//
//  NotFoundView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 15/7/25.
//

import SwiftUI

struct NotFoundView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.orange)

            Text("404")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.primary)

            Text("Trang bạn tìm không tồn tại.")
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            Button(action: {
                // Điều hướng về trang chính hoặc pop view
                // Ví dụ nếu dùng NavigationStack:
                // navigationPath.removeLast(navigationPath.count)
            }) {
                Text("Quay lại trang chủ")
                    .fontWeight(.medium)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 32)
        }
        .padding()
    }
}

#Preview {
    NotFoundView()
}
