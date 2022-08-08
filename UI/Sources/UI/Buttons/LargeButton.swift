//
//  LargeButton.swift
//  Tolls
//
//  Created by Matias Contreras on 12-07-22.
//

import SwiftUI
import Theme

/* The same view but as a ViewModifier
public struct LargeButton: ViewModifier {
    var text = "No text"
    @Binding var isDisabled: Bool
    @Binding var isLoading: Bool
    var action: (() -> Void)?

    private var buttonBackground: Color {
        (isDisabled || isLoading) ? Color.DefaulTheme.disabledButton : Color.DefaulTheme.primaryAccent
    }

    public func body(content: Content) -> some View {
        ZStack {
            Button(action: action ?? { }) {
                Spacer()
                Text(isLoading ? "" : text)
                    .bold()
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 28)
            .padding(12)
            .background(buttonBackground)
            .foregroundColor(.white)
            .cornerRadius(5)
            .disabled(isDisabled || isLoading)
            .animation(.linear(duration: 0.3), value: isLoading)
            ActivityIndicator(isAnimating: .constant(true), style: .medium)
                .opacity(isLoading ? 1 : 0)
        }
    }
}

public extension View {
    func largeButton(
            text: String,
            isDisabled: Binding<Bool>,
            isLoading: Binding<Bool>,
            action: (() -> Void)? = nil) -> some View {
        modifier(LargeButton(text: text, isDisabled: isDisabled, isLoading: isLoading, action: action))
    }
}*/

public struct LargeButton: View {
    var text = "No text"
    @Binding var isDisabled: Bool
    @Binding var isLoading: Bool
    var action: (() -> Void)

    public init(
        text: String,
        isDisabled: Binding<Bool> = .constant(false),
        isLoading: Binding<Bool> = .constant(false),
        action: @escaping () -> Void = { }) {
        self.text = text
        _isDisabled = isDisabled
        _isLoading = isLoading
        self.action = action
    }

    private var buttonBackground: Color {
        (isDisabled || isLoading) ? Color(asset: ThemeColor.disabledButton) :
        Color(asset: ThemeColor.primaryAccent)
        //(isDisabled || isLoading) ? ThemeColor.disabledButton : ThemeColor.primaryAccent
    }

    public var body: some View {
        ZStack {
            Button(action: action) {
                Spacer()
                Text(isLoading ? "" : text)
                    .bold()
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 28)
            .padding(12)
            .background(buttonBackground)
            .foregroundColor(.white)
            .cornerRadius(5)
            .disabled(isDisabled || isLoading)
            .animation(.linear(duration: 0.3), value: isLoading)
            ActivityIndicator(isAnimating: .constant(true), style: .medium)
                .opacity(isLoading ? 1 : 0)
        }
    }
}

struct LargeButton_Previews: PreviewProvider {
    static var previews: some View {
        LargeButton(text: "Hola", isDisabled: .constant(true), isLoading: .constant(true))
    }
}
