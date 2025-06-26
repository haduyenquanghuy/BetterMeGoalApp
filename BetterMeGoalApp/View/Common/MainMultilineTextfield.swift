//
//  MainMultilineTextfield.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 26/6/25.
//

import SwiftUI

struct MainMultilineTextfield: View {
    
    @Binding var text: String
    var title: String
    var placeholderText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .avertaFont(size: 14)
                .fontWeight(.regular)
                .foregroundStyle(.ink80)
            
            TextField(placeholderText, text: $text,  axis: .vertical)
                .textFieldStyle(.plain)
                .font(BMFont.averta.font(with: 14))
                .autocorrectionDisabled(true)
                .lineLimit(5...10)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.grayBorder, lineWidth: 1)
                }
        }
        
    }
}

#Preview {
    MainMultilineTextfield(text: .constant("abc"), title: "Description", placeholderText: "Tell us something about this goal...")
}
