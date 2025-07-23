//
//  TaskCompleteDialogView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 23/7/25.
//

import SwiftUI

struct TaskCompleteDialogView: View {
    var taskTitle: String = "Reading 5 pages"
    var quote: String = "Great job! Small steps lead to big changes."

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 60))
                .foregroundColor(.green)
                .scaleEffect(1.2)
                .transition(.scale.combined(with: .opacity))
            
            Text("Task Completed!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Text(taskTitle)
                .font(.headline)
                .foregroundColor(.secondary)

            Text("“\(quote)”")
                .font(.subheadline)
                .italic()
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: {
                // Dismiss logic here
            }) {
                Text("Continue")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green.opacity(0.9))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding(30)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(radius: 20)
        .padding()
    }
}


#Preview {
    TaskCompleteDialogView()
}
