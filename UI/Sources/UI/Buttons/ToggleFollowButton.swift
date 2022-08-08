//
//  ToggleFollowButton.swift
//  Tolls
//
//  Created by m.contreras.selman on 03-07-22.
//

import SwiftUI

public struct ToggleFollowButton: View {
    enum ButtonState {
        case locationTrackingActive
        case locationTrackingDeactivated
    }

    @State var state = ButtonState.locationTrackingActive
    var action: () -> Void

    public init(_ action: @escaping () -> Void) {
        self.action = action
    }

    public var body: some View {
        ZStack {
            ZStack {
                Button(action: {
                    switch state {
                    case .locationTrackingActive:
                        self.state = .locationTrackingDeactivated
                    case .locationTrackingDeactivated:
                        self.state = .locationTrackingActive
                    }

                    action()
                }) {
                    Image(systemName: "location")
                        .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    // .shadow(color: Color(uiColor: .black), radius: 5, x: 0, y: 5)
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: Alignment.topTrailing
            )
        }.padding()
            .opacity(state == .locationTrackingActive ? 1 : 0.5)
            .allowsHitTesting(true)
    }
}

struct ToggleFollowButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleFollowButton {}
    }
}
