//
//  EditReviewGoalField.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 4/7/25.
//

import SwiftUI

struct EditReviewGoalTargetView : View {
    
    @Binding var text: String
    
    @State var isEdit: Bool = false
    
    @State var saveText: String = ""
    
    @FocusState var isFocus
    
    var body: some View {
      
            if isEdit {
                HStack {
                    TextField("Set Target", text: $text)
                        .font(BMFont.averta.font(with: 18))
                        .focused($isFocus)
                        .keyboardType(.numberPad)
                    
                    Spacer()
                    
                    Image(.icRemove)
                        .resizeImageFit(width: 16)
                        .onTapGesture {
                            isEdit = false
                            isFocus = false
                            text = saveText
                        }
                }
            } else {
                EditLabelView(text: text) {
                    saveText = text
                    isEdit = true
                    isFocus = true
                }
            }
        
    }
}

struct EditReviewGoalTitletView : View {
    
    let title: String
    let placeholder: String
    @Binding var text: String
    
    @State var isEdit: Bool = false
    
    @State var saveText: String = ""
    
    @FocusState var isFocus
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                
                Text(title)
                    .avertaFont(size: 14)
                    .foregroundStyle(.ink60)
                    .fontWeight(.regular)
                
                TextField("Name", text: $text)
                    .font(BMFont.averta.font(with: 18))
                    .focused($isFocus)
                
            }
            
            if isEdit {
                Image(.icRemove)
                    .resizeImageFit(width: 16)
                    .onTapGesture {
                        isEdit = false
                        isFocus = false
                        text = saveText
                    }
            } else {
                Image(.icEdit)
                    .resizeImageFit(width: 16)
                    .onTapGesture {
                        saveText = text
                        isEdit = true
                        isFocus = true
                    }
            }
            
        }
    }
}

struct EditReviewGoalDeadlineView: View {
    
    @Binding var text: String 
    @State var saveText: String = ""
    @Binding var isShowCalendar: Bool
    
    var body: some View {
        EditLabelView(text: text) {
            saveText = text
            withAnimation(.linear(duration: 0.25)) {
                isShowCalendar = true
            }
        }
    }
}

struct EditLabelView: View {
    
    var text: String
    var onTapEdit: () -> ()
    
    var body: some View {
        HStack {
            Text(text)
                .avertaFont(size: 18)
            
            Spacer()
            
            Image(.icEdit)
                .resizeImageFit(width: 16)
                .onTapGesture {
                    onTapEdit()
                }
        }
    }
}
