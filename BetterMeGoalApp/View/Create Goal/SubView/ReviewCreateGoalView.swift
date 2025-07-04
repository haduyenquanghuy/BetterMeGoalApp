//
//  ReviewCreateGoalView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 3/7/25.
//

import SwiftUI

struct ReviewCreateGoalView: View {
    
    @State private var name = ""
    @State private var description = ""
    @State private var deadline = ""
    @State private var goalTarget = ""
    
    @State private var showCalendar: Bool = false
    @State private var date = Date()
    
    @Binding var createdGoal: GoalModel
    
    var body: some View {
        VStack(spacing: 16) {
            CustomSection {
                Text("1. Title & Description").latoFont(size: 14)
            } content: {
                VStack(spacing: 12) {
                    EditReviewGoalTitletView(title: "title", placeholder: "Enter title", text: $createdGoal.title.unwrapped)
                    
                    Divider()
                    
                    EditReviewGoalTitletView(title: "description", placeholder: "Enter description", text: $createdGoal.description.unwrapped)
                }
            }
            
            CustomSection {
                Text("2. Goal Target")
                    .latoFont(size: 14)
            } content: {
                EditReviewGoalTargetView(text: $createdGoal.description.unwrapped)
            }

            CustomSection {
                Text("3. Deadline")
                    .latoFont(size: 14)
            } content: {
                EditReviewGoalDeadlineView(text:$createdGoal.deadline.unwrapped, isShowCalendar: $showCalendar)
            }
            
        }
        .overlay(
            CalendarOverlayView(show: $showCalendar, date: $date)
        )
        .onAppear {
            
        }
    }
}

struct CalendarOverlayView: View {
    @Binding var show: Bool
    @Binding var date: Date
    
    var body: some View {
        if show {
            ZStack {
                // Nền mờ
                Color.black.opacity(0.36)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            show = false
                        }
                    }

                VStack(spacing: 12) {
                    DatePicker(
                        "Deadline",
                        selection: $date,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.graphical)
                    .padding()

                    HStack(spacing: 20) {
                        Spacer()
                        
                        Button("OK") {
                            withAnimation {
                                show = false
                            }
                        }
                        .padding(.trailing, 12)

                        Button("Cancel") {
                            withAnimation {
                                show = false
                            }
                        }
                    }
                    .frame(height: 44)
                    .padding(.horizontal)
                }
                .background(Color.white)
                .cornerRadius(20)
                .padding()
            }
        }
    }
}

#Preview {
    ReviewCreateGoalView(createdGoal: .constant(GoalModel()))
}

struct CustomSection<Title: View, Content: View>: View {
    let title: Title
    let content: Content

    init(
        @ViewBuilder title: () -> Title,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title()
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            title
                .padding(.horizontal, 20)
                .foregroundColor(.secondary)
                .textCase(.uppercase)
                
            content
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color(.white))
                .cornerRadius(12)
        }
        .padding(.vertical, 8)
    }
}
