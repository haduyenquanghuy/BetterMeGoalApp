//
//  MainTabbarView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 20/6/25.
//

import SwiftUI

struct MainTabbarView: View {
    
    @Binding var selectedTab: TabSection
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ForEach(TabSection.allCases, id: \.hashValue) { tabSection in
                if let tab = tabSection.item {
                    VStack(spacing: 8) {
                        Image(tabSection == selectedTab ? tab.selectedImage : tab.image)
                            .resizable()
                            .frame(width: 24, height: 24)
                        
                        Text(tab.title)
                            .avertaFont(size: 12)
                            .fontWeight(.semibold)
                            .foregroundStyle(tabSection == selectedTab ? Color.bluePrimary : Color.ink100)
                        
                    }
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, maxHeight: 64)
                    .background(Color.white)
                    .onTapGesture {
                        selectedTab = tabSection
                    }
                } else {
                    ZStack {
                        
                        Color.white
                            
                        Button {
                            
                        } label: {
                            Circle()
                                .fill(Color.white)
                                .frame(maxWidth: .infinity)
                                .overlay {
                                    Circle()
                                        .fill(Color(.bluePrimary))
                                        .padding(3)
                                        .overlay {
                                            Image(.icPlus)
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                }
                         
                        }
                        .offset(y: -24)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 64)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 64)
    }
}

#Preview {
    MainTabbarView(selectedTab: .constant(.add))
}

