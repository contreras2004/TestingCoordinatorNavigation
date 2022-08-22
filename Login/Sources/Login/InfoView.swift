//
//  InfoView.swift
//  
//
//  Created by m.contreras.selman on 09-08-22.
//

import Foundation
import Navigation
import SwiftUI
import Theme
import UI

public class InfoViewModel: BaseViewModel { }

public struct InfoView: View {
    @ObservedObject var viewModel: InfoViewModel
    @Namespace var animation
    @State var shouldAnimate = false

    public init(viewModel: InfoViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            Spacer()
            Text("Tap me! 😄")
                .foregroundColor(.white)
            ZStack {
                if shouldAnimate {
                    ZStack {
                        Circle()
                            .matchedGeometryEffect(id: "circle", in: animation)
                            .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.9))
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    shouldAnimate.toggle()
                                }
                            }
                        Text("This is a modal")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                } else {
                    ZStack {
                        Circle()
                            .matchedGeometryEffect(id: "circle", in: animation)
                            .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.4))
                            .frame(width: 180, height: 180)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    shouldAnimate.toggle()
                                }
                            }
                        Text("This is a modal")
                            .foregroundColor(.white)
                    }
                }
            }.padding()

            Text("To show any modal you should send a new value for the viewModelForModal in the coordinator")
                .foregroundColor(.white)
                .padding()
                .multilineTextAlignment(.center)
            DefaultButton(text: "Dismiss modal") {
                self.viewModel.coordinator.handle(event: LoginEvents.dismissModal)
            }
            Spacer()
        }
        .padding()
        .withAnimatedBackground()
    }
}
