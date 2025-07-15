//
//  SetGoalDeadlineView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 3/7/25.
//

import SwiftUI

struct SetGoalDeadlineView: View {
    
    @State var isShowCalendar: Bool = false
    @Binding var selectedDate: String?
    @State private var date = Date()
    
    var body: some View {
        
        VStack {
            HStack(spacing: 0) {
                HStack(spacing: 12) {
                    Image(.icCalendar1)
                        .resizeImageFit(width: 18)
                    
                    if let selectedDate = selectedDate {
                        Text(selectedDate)
                            .avertaFont(size: 16)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    } else {
                        Text("Select a date")
                            .avertaFont(size: 16)
                            .foregroundStyle(.ink60)
                    }
                    
                    if selectedDate != nil {
                        Button {
                            withAnimation(.linear(duration: 0.16)) {
                                selectedDate = nil
                            }
                        } label: {
                            Image(.icClearRound)
                                .resizeImageFit(width: 20, isOriginal: false)
                        }
                        .foregroundStyle(.red)
                    }
                }
                
                Spacer()
                
                    
                Button {
                    withAnimation(.linear(duration: 0.16)) {
                        isShowCalendar.toggle()
                    }
                } label: {
                    Image(.icArrowLeft)
                        .resizeImageFit(width: 20)
                        .rotationEffect(.degrees(isShowCalendar ? 90 : 0))
                }
                
            }
            .contentShape(RoundedRectangle(cornerRadius: 12))
            .onTapGesture {
                withAnimation(.linear(duration: 0.16)) {
                    isShowCalendar = true
                }
            }
            
            if isShowCalendar {
                DatePicker(
                        "Start Date",
                        selection: $date,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                .datePickerStyle(.graphical)
                .onChange(of: date) {
                    selectedDate = BMDateFormatter.shared.string(from: date, format: .fullWithMonthName)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(12)
    }
}

#Preview {
    VStack {
        SetGoalDeadlineView(selectedDate: .constant("Oct 15, 2025"))
        
        SetGoalDeadlineView(selectedDate: .constant(nil))
    }
    .padding(12)
    .background(Color.yellow)
}
