//
//  CreateGoalScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 24/6/25.
//

import SwiftUI

struct SelectGoalTypeScreen: View {
    
    @EnvironmentObject var router: Router
    @State var activeCard: GoalType?
    @Binding var isShow: Bool
    
    var body: some View {
        
        NavigationStack(path: $router.createRoutes) {
            VStack(spacing: 24) {
                
                Spacer()
                
                listCarouselCards
                
                pagingControl
                
                Spacer()
                
                // Button Section
                HStack(spacing: 12) {
                    Image(.icPrev)
                        .resizeImageFit(width: 36)
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.25)) {
                                activeCard = activeCard?.prev()
                            }
                        }
                        .disabled(activeCard?.prev() == nil)
                        .opacity(activeCard?.prev() == nil ? 0.25 : 1)
                    
                    MainButton(title: "Select Template") {
                        router.createRoutes.append(.create)
                    }
                    .frame(width: 200)

                    Image(.icNext)
                        .resizeImageFit(width: 36)
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.25)) {
                                activeCard = activeCard?.next()
                            }
                        }
                        .opacity(activeCard?.next() == nil ? 0.25 : 1)
                        .disabled(activeCard?.next() == nil)
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Choose Goal Template")
                        .avertaFont(size: 18)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button {
                        isShow = false
                    } label: {
                        Image(.icRemove)
                            .renderingMode(.template)
                            .resizeImageFit(width: 24)
                            .foregroundStyle(Color.white)
                    }
                    
                }
            }
            .toolbarBackground(.bluePrimary, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .onAppear {
                activeCard = GoalType.all.first
            }
            .navigationDestination(for: CreateRoute.self) { route in
                switch route {
                    case .create:
                        CreateGoalFlowScreen()
                }
            }
        }
    }
    
    var listCarouselCards: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 24) {
                ForEach(GoalType.all, id: \.self) { type in
                    GoalTypeCardView(cardUI: type.dislay, width: 264)
                        .shadow(radius: 5, x: 5, y: 5)
                        .scrollTransition() { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.72)
                            
                        }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(24, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $activeCard)
        .scrollIndicators(.never)
    }
    
    var pagingControl: some View {
        HStack {
            ForEach(GoalType.all) { card in
                Button {
                    withAnimation {
                        activeCard = card
                    }
                } label: {
                    Circle()
                        .fill(Color(.bluePrimary).opacity(activeCard == card ? 1 : 0.1))
                        .frame(width: 10, height: 10)
                        .scaleEffect(activeCard == card ? 1.2 : 0.8)
                        .animation(.spring(), value: activeCard)
                }
            }
        }
    }
}

#Preview {
    SelectGoalTypeScreen(isShow: .constant(true))
        .environmentObject(Router())
}
