//
//  SetGoalTargetView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 30/6/25.
//

import SwiftUI

struct SetGoalTargetView: View {
    
    @EnvironmentObject var store: CreateStore
    @FocusState private var isFocus: Bool
    @StateObject private var inputUser = UserInputModel()
    @State private var isSet = false
    
    var body: some View {
        setTagetView
    }
    
    var setTagetView: some View {
        VStack(spacing: 12) {
            ZStack {
                if isSet {
                    TextField(text: $inputUser.inputText, label: {
                        Text("Set your target")
                            .avertaFont(size: 40)
                    })
                    .textFieldStyle(.plain)
                    .onSubmit {
                        withAnimation(.linear(duration: 0.25)) {
                            isSet = false
                        }
                    }
                    .font(BMFont.averta.font(with: 96))
                    .foregroundStyle(.black)
                    .focused($isFocus)
                    .padding(.horizontal, 16)
                    .keyboardType(.numberPad)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button {
                                showTextField(isShow: false)
                            } label: {
                                Text("Done")
                                    .font(.system(size: 18))
                                    .foregroundStyle(.bluePrimary)
                            }
                        }
                    }
                    
                } else {
                    HStack(alignment: .lastTextBaseline, spacing: 4) {
                        
                        Text(inputUser.numberLbl)
                            .font(BMFont.averta.font(with: 96))
                            .lineLimit(1)
                        
                        Text(store.state.createdGoal.goalType.title)
                            .avertaFont(size: 16)
                            .fontWeight(.regular)
                            .foregroundStyle(.ink80)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.25), value: isSet)
                }
            }
            .frame(height: 120, alignment: .bottom)
            
            HStack(spacing: 8) {
                Button {
                    showTextField(isShow: true)
                } label: {
                    HStack(spacing: 8) {
                        
                        Image(.icPlus)
                            .resizeImageFit(width: 16, isOriginal: false)
                            .foregroundStyle(.bluePrimary)
                        
                        Text("Enter your value")
                            .avertaFont(size: 16)
                            .fontWeight(.semibold)
                            .foregroundStyle(.bluePrimary)
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 36)
                    .background(Color.bluePrimary.opacity(0.05))
                    .cornerRadius(32)
                }
                
                Button {
                    showTextField(isShow: false)
                    inputUser.reload()
                } label: {
                    Image(.icRemove)
                        .resizeImageFit(width: 16, isOriginal: false)
                        .foregroundStyle(.bluePrimary)
                        .frame(width: 36, height: 36)
                        .background(Color.bluePrimary.opacity(0.05))
                        .cornerRadius(20)
                }

            }
            .padding(.bottom, 16)
        }
        .background(Color.white)
        .cornerRadius(4)
    }
    
    func showTextField(isShow: Bool) {
        withAnimation(.linear(duration: 0.16)) {
            isSet = isShow
        }
        isFocus = isShow
    }
}

#Preview {
    SetGoalTargetView()
        .frame(maxHeight: .infinity)
        .background(Color.ink5)
        .environmentObject(CreateStore())
}
