//
//  LoadingView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 8/7/25.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    var text: String = "Đang tải..."
    
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1.5)
            
            Text(text)
                .foregroundColor(.white)
                .font(.headline)
        }
        .padding(24)
        .background(Color.black.opacity(0.75))
        .cornerRadius(16)
        .shadow(radius: 10)
    }
}

extension View {
    @ViewBuilder
    func showLoading(isPresented: Bool, text: String = "Đang tải...") -> some View {
        if isPresented {
            self
                .overlay {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .overlay(
                            LoadingView(text: text)
                        )
                }
        } else {
            self
        }
    }
}
