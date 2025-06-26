//
//  View+.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 17/6/25.
//

import Foundation
import SwiftUI

extension View {
    
    func makeGird() -> some View {
        padding(.horizontal, 16)
    }
    
    func customTabbar() -> some View {
        self.navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.bluePrimary, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func viewShouldHide(with value: Bool) -> some View {
        self.blur(radius: value ? 6 : 0)
            .disabled(value ? true : false)
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> SwiftUI.Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]
    
    func path(in rect: CGRect) -> SwiftUI.Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                    case .top, .bottom, .leading: return rect.minX
                    case .trailing: return rect.maxX - width
                }
            }
            
            var y: CGFloat {
                switch edge {
                    case .top, .leading, .trailing: return rect.minY
                    case .bottom: return rect.maxY - width
                }
            }
            
            var w: CGFloat {
                switch edge {
                    case .top, .bottom: return rect.width
                    case .leading, .trailing: return width
                }
            }
            
            var h: CGFloat {
                switch edge {
                    case .top, .bottom: return width
                    case .leading, .trailing: return rect.height
                }
            }
            path.addRect(CGRect(x: x, y: y, width: w, height: h))
        }
        return path
    }
}

