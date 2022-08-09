//
//  DefaultTextField.swift
//  Tolls
//
//  Created by Matias Contreras on 12-07-22.
//

import SwiftUI
import Theme

public struct DefaultTextField: View {
    var placeholder: String = ""
    var isSecure = false
    @Binding var value: String
    @Binding var errorMessage: String

    public init(
        placeholder: String,
        isSecure: Bool = false,
        value: Binding<String> = .constant(""),
        errorMessage: Binding<String> = .constant("")
    ) {
        self.placeholder = placeholder
        self.isSecure = isSecure
        _value = value
        _errorMessage = errorMessage
    }

    public var body: some View {
        VStack {
            if isSecure {
                SecureField(placeholder, text: $value)
                    .padding(.horizontal, 15)
                    .frame(height: 48.0)
                    .background(Color(asset: ThemeColor.textfieldBackground))
                    .cornerRadius(5)
            } else {
                TextField(placeholder, text: $value)
                    .padding(.horizontal, 15)
                    .frame(height: 48.0)
                    .background(Color(asset: ThemeColor.textfieldBackground))
                    .cornerRadius(5)
            }
            if !errorMessage.isEmpty {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .foregroundColor(.red)
                        .frame(width: 10, height: 10)
                    Text(errorMessage)
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                    Spacer()
                }
            }
        }
    }
}

struct DefaultTextField_Previews: PreviewProvider {
    static var previews: some View {
        DefaultTextField(placeholder: "", value: .constant("Hola"))
    }
}
