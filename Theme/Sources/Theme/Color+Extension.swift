//
//  Colors.swift
//  Tolls
//
//  Created by Matias Contreras on 12-07-22.
//
import Foundation
import SwiftUI

// swiftlint: disable missing_docs
/*public extension Color {
    enum DefaulTheme {
        public static let textfieldBackground    = Color("TextfieldBackground")
        public static let primaryAccent          = Color("PrimaryAccent")
        public static let disabledButton         = Color("DisabledButton")
    }
}*/

public extension Color {
    private struct RGBAComponents {
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let alpha: CGFloat
    }

    init(_ named: String) {
        self.init(named, bundle: Bundle.module)
    }

    var uiColor: UIColor {
        if #available(iOS 14.0, *) {
            return UIColor(self)
        } else {
            let components = self.components()
            return UIColor(
                red: components.red,
                green: components.green,
                blue: components.blue,
                alpha: components.alpha
            )
        }
    }

    private func components() -> RGBAComponents {
            let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
            var hexNumber: UInt64 = 0
            var red: CGFloat = 0.0,
                green: CGFloat = 0.0,
                blue: CGFloat = 0.0,
                alpha: CGFloat = 0.0

            let result = scanner.scanHexInt64(&hexNumber)
            if result {
                red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                alpha = CGFloat(hexNumber & 0x000000ff) / 255
            }
            return RGBAComponents(red: red, green: green, blue: blue, alpha: alpha)
        }
}
