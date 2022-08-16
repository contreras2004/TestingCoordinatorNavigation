//
//  AnimatedBackground.swift
//  
//
//  Created by m.contreras.selman on 12-08-22.
//

import Foundation
import SwiftUI
import Theme

public struct AnimatedBackground: View {
    public init() {}

    @Namespace var namespace

    @State var isAnimating1 = false
    @State var isAnimating2 = false
    @State var isAnimating3 = false

    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topTrailing, content: {
                Color.black
                    .ignoresSafeArea()
                    .frame(width: geo.size.width * 2, height: geo.size.height * 2)

                Circle()
                    .frame(width: geo.size.width * 1.3, height: geo.size.width * 1.6)
                    .foregroundColor(ThemeColor.primaryAccent.swiftUIColor)
                    .scaleEffect(isAnimating1 ? 1.2 : 1)
                    .position(
                        x: isAnimating1 ? geo.size.width * 0.5 : -geo.size.width * 0.1,
                        y: isAnimating1 ? -200 : 0 )
                    .opacity(isAnimating1 ? 0.8 : 0.5)

                Circle()
                    .frame(width: geo.size.width * 0.35, height: geo.size.width * 1.6)
                    .foregroundColor(ThemeColor.secondaryAccent.swiftUIColor)
                    .scaleEffect(isAnimating2 ? 1.5 : 1)
                    .position(
                        x: isAnimating2 ? geo.size.width * 0.6 : geo.size.width * 0.8,
                        y: isAnimating2 ? geo.size.height * 0.5 : geo.size.height * 0.3)
                    .opacity(isAnimating2 ? 0.6 : 0.4)

                Circle()
                    .frame(width: geo.size.width * 0.5, height: geo.size.width * 1.6)
                    .foregroundColor(ThemeColor.thirdAccent.swiftUIColor)
                    .scaleEffect(isAnimating2 ? 1.5 : 1)
                    .position(
                        x: isAnimating2 ? geo.size.width * 0.5 : geo.size.width * 0.2,
                        y: isAnimating2 ? geo.size.height * 0.8 : geo.size.height * 0.7)
                    .opacity(isAnimating2 ? 0.7 : 0.5)
            }).frame(width: geo.size.width * 2, height: geo.size.height * 2)
            .onAppear {
                withAnimation(.easeInOut(duration: 6).repeatForever().delay(0)) {
                    self.isAnimating1 = true
                }
                withAnimation(.easeInOut(duration: 4).repeatForever().delay(0)) {
                    self.isAnimating2 = true
                }
                withAnimation(.easeInOut(duration: 5).repeatForever().delay(0)) {
                    self.isAnimating3 = true
                }
            }
        }
        .drawingGroup()
        .blur(radius: 70)
    }
}

public struct AnimatedBackgroundModifier: ViewModifier {
    public func body(content: Content) -> some View {
        GeometryReader { geo in
            ZStack {
                AnimatedBackground().frame(width: geo.size.width * 1.5, height: geo.size.height * 1.5)
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.5)
                content
            }
        }
    }
}

public extension View {
    func withAnimatedBackground() -> some View {
        modifier(AnimatedBackgroundModifier())
    }
}
