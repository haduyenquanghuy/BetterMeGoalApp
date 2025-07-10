//
//  GoalProgressView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 10/7/25.
//

import SwiftUI

struct GoalProgressView: View {
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading) {
                ZStack {
                    Image(.icStar)
                        .resizeImageFit(width: 20)
                        .frame(width: 36, height: 36)
                        .background(Color(hex: "FDD0AB"))
                        .cornerRadius(118)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Target")
                        .avertaFont(size: 18)
                        .foregroundStyle(.ink80)
                    
                    Text("10.000h")
                        .avertaFont(size: 24)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 12)
            .padding(.leading, 16)
            .padding(.trailing, 12)
            .aspectRatio(1, contentMode: .fit)
            .background(Color(hex: "FDDEC2"))
            .cornerRadius(32)
            
            VStack(alignment: .leading) {
                ZStack {
                    Image(.icChartRing)
                        .resizeImageFit(width: 20)
                        .frame(width: 36, height: 36)
                        .background(Color(hex: "D8D5FB"))
                        .cornerRadius(118)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("64%")
                            .avertaFont(size: 18)
                            .fontWeight(.semibold)
                            .foregroundStyle(.ink100)
                        
                        Text("Progress")
                            .avertaFont(size: 14)
                            .foregroundStyle(.ink80)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("123h")
                            .avertaFont(size: 16)
                            .fontWeight(.semibold)
                            .foregroundStyle(.ink100)
                        
                        Text("Complete")
                            .avertaFont(size: 14)
                            .foregroundStyle(.ink80)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 12)
            .padding(.leading, 16)
            .padding(.trailing, 12)
            .aspectRatio(1, contentMode: .fit)
            .background {
                ZStack {
                    Color(hex: "E6E5FD")
                    
                    WaveBackgroundView()
                }
            }
            .cornerRadius(32)
        }
        .addTitle("Progress")
    }
}

#Preview {
    GoalProgressView()
}
