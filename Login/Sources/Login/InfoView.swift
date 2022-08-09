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

    public init(viewModel: InfoViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack {
            ThemeColor.primaryAccent.swiftUIColor
            VStack {
                Spacer()
                Text("This is a modal")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text("To show any modal you should override the property \"viewModelForModal\" in the parent View")
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                LargeButton(text: "Dismiss modal") {
                    self.viewModel.coordinator.handle(event: LoginEvents.dismissModal)
                }
                Spacer()
            }
        }.ignoresSafeArea()
    }
}
