//
//  CalendarOverlayView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 4/7/25.
//

import SwiftUI

struct CalendarOverlayView: View {
    @Binding var show: Bool
    @Binding var selectedDate: String
    @State var date = Date()
    
    var body: some View {
        if show {
            ZStack {
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

                    VStack(spacing: 8) {
                        
                        Button {
                            show = false
                            selectedDate = ""
                            
                        } label: {
                            Text("No Deadline")
                                .avertaFont(size: 16)
                                .frame(height: 36)
                                .frame(maxWidth: .infinity)
                                .background(Color.secondary)
                                .foregroundStyle(.white)
                                .cornerRadius(18)
                        }
                        
                        
                        Button {
                            show = false
                            selectedDate =  BMDateFormatter.shared.string(from: date, format: .fullWithMonthName)
                            
                        } label: {
                            Text("OK")
                                .avertaFont(size: 16)
                                .frame(height: 36)
                                .frame(maxWidth: .infinity)
                                .background(Color.darkBlue)
                                .foregroundStyle(.white)
                                .cornerRadius(18)
                        }
                        
                        Button {
                            show = false
                        } label: {
                            Text("Cancel")
                                .avertaFont(size: 16)
                                .frame(height: 36)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .foregroundStyle(Color.ink80)
                                .cornerRadius(18)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 12)
                }
                .background(Color.white)
                .cornerRadius(20)
                .padding()
            }
        }
    }
}


#Preview {
    CalendarOverlayView(show: .constant(true), selectedDate: .constant(""))
}
