//
//  CreateTaskByQualityView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 15/7/25.
//

import SwiftUI

struct CreateTaskByQualityView: View {
    
    let goal: GoalModel
    @FocusState var isFocus: Bool
    @State var isEdit: Bool = false
    @StateObject var userInput = UserInputNumberModel()
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var goalStore: GoalStore
    
    var body: some View {
        
        VStack {
            VStack(spacing: 0) {
                VStack(spacing: 4) {
                    Text(goal.title ?? "")
                        .avertaFont(size: 22)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Text(goal.description ?? "")
                        .avertaFont(size: 16)
                        .fontWeight(.regular)
                        .foregroundStyle(.ink80)
                }
                
                HStack(spacing: 8) {
                    EditValueButtonView(image: .icMinusSign) {
                        userInput.sub(with: 1)
                    }
                    .disabled(isEdit)
                    
                    VStack(spacing: isEdit ? 12 : 8) {
                        
                        if isEdit {
                            TextField(text: $userInput.inputText.unwrapped, label: {
                                Text("Set your target")
                                    .avertaFont(size: 14)
                            })
                            .onSubmit {
                                isEdit = false
                            }
                            .font(BMFont.averta.font(with: 16))
                            .textFieldStyle(.plain)
                            .frame(height: 44)
                            .padding(.horizontal, 12)
                            .background(Color.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 12)
                            .focused($isFocus)
                            .keyboardType(.numberPad)
                            .onChange(of: userInput.inputText) {
                                userInput.sync()
                            }
                      
                        } else {
                            Text("\(userInput.number)")
                                .avertaFont(size: 48)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                                .frame(height: 44)
                        }
                        
                        Text("TIMES")
                            .avertaFont(size: 14)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    .frame(height: 108, alignment: .center)
                    .frame(maxWidth: .infinity)
                    .background(Color.ink10)
                    .cornerRadius(16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(Color.bluePrimary, lineWidth: isEdit ? 2 : 0)
                    }
                    
                    EditValueButtonView(image: .icPlusSign) {
                        userInput.add(with: 1)
                    }
                    .disabled(isEdit)
                }
                .padding(.top, 32)
                
                HStack(spacing: 8) {
                    
                    Spacer()
                    
                    Button {
                        isEdit = true
                        isFocus = true
                    } label: {
                        HStack(spacing: 8) {
                            Text("Edit")
                                .avertaFont(size: 16)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.bluePrimary))
                        }
                        .frame(width: 80, height: 32)
                        .background(Color.ink5)
                        .cornerRadius(18)
                    }
                    
                    Button {
                        userInput.refresh()
                    } label: {
                        HStack(spacing: 8) {
                            Text("Delete")
                                .avertaFont(size: 16)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(hex: "7C7C7C"))
                        }
                        .frame(width: 80, height: 32)
                    }
                }
                .padding(.top, 16)
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(24)
            .padding(.horizontal, 12)
            .padding(.top, 32)
            
            Spacer()
            
            MainButton(height: 44, title: "Start now") {
                router.goalRoutes.append(.taskInProgress(goal: goal))
                goalStore.send(.setTargetForQuantityGoal(userInput.number))
            }
            .padding(.bottom, 12)
            .padding(.horizontal, 16)
        }
        .background(Color(.background))
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Create Task")
                    .avertaFont(size: 18)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                
                Button {
                    router.goalRoutes.removeLast()
                } label: {
                    Image(.icBack)
                        .resizeImageFit(width: 28, isOriginal: false)
                        .foregroundStyle(Color.white)
                }
            }
            
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    isEdit = false
                    isFocus = false
                }
            }
        }
        .customNavigationBar()
    }
}

struct EditValueButtonView : View {
    
    var image: ImageResource
    var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(image)
                    .resizeImageFit(width: 28, isOriginal: false)
                    .foregroundStyle(Color(hex: "7C7C7C"))
            }
            .frame(width: 72, height: 108)
            .background(Color.ink10)
            .cornerRadius(16)
        }

    }
}

#Preview {
    CreateTaskByQualityView(goal: GoalModel(title: "Buy a new house", description: "Save money to buy a new house"))
        .environmentObject(GoalStore(service: GoalService(), shareStore: ShareStore()))
}
