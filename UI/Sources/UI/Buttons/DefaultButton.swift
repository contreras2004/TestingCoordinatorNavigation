//
//  LargeButton.swift
//  Tolls
//
//  Created by Matias Contreras on 12-07-22.
//

import SwiftUI
import Theme

public struct DefaultButton: View {
    public enum Style {
        case filled, onlyText
    }

    var text = "No text"
    @Binding var isDisabled: Bool
    @Binding var isLoading: Bool
    var action: (() -> Void)
    let style: Style

    public init(
        text: String,
        isDisabled: Binding<Bool> = .constant(false),
        isLoading: Binding<Bool> = .constant(false),
        style: Style = .filled,
        action: @escaping () -> Void = { }) {
        self.text = text
        _isDisabled = isDisabled
        _isLoading = isLoading
        self.action = action
        self.style = style
    }

    private var foregroundColor: Color {
        switch style {
        case .filled:
            return .white
        case .onlyText:
            return ThemeColor.primaryAccent.swiftUIColor
        }
    }

    private var buttonBackground: Color {
        switch style {
        case .filled:
            return (isDisabled || isLoading) ? ThemeColor.disabledButton.swiftUIColor :
            ThemeColor.primaryAccent.swiftUIColor
        case .onlyText:
            return Color(red: 0, green: 0, blue: 0, opacity: 0)
        }
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
            .foregroundColor(foregroundColor)
            .cornerRadius(5)
            .disabled(isDisabled || isLoading)
            .animation(.linear(duration: 0.3), value: isLoading)
            ActivityIndicator(isAnimating: .constant(true), style: .medium)
                .opacity(isLoading ? 1 : 0)
        }// .shadow(color: ThemeColor.primaryAccent.swiftUIColor, radius: style == .filled ? 5 : 0)
    }
}

struct LargeButton_Previews: PreviewProvider {
    static var previews: some View {
        DefaultButton(text: "Hola", isDisabled: .constant(true), isLoading: .constant(true))
    }
}
