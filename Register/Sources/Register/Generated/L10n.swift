// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// I accept the Terms and Conditions
  internal static let acceptTC = L10n.tr("Localizable", "acceptTC", fallback: #"I accept the Terms and Conditions"#)
  /// Email
  internal static let email = L10n.tr("Localizable", "email", fallback: #"Email"#)
  /// Name
  internal static let name = L10n.tr("Localizable", "name", fallback: #"Name"#)
  /// Plural format key: "%#@views@"
  internal static func nViews(_ p1: Int) -> String {
    return L10n.tr("Localizable", "nViews", p1, fallback: #"Plural format key: "%#@views@""#)
  }
  /// ******
  internal static let passPlaceholder = L10n.tr("Localizable", "passPlaceholder", fallback: #"******"#)
  /// Password
  internal static let password = L10n.tr("Localizable", "password", fallback: #"Password"#)
  /// Register
  internal static let registerTitle = L10n.tr("Localizable", "registerTitle", fallback: #"Register"#)
  /// Repeat password
  internal static let repeatPassword = L10n.tr("Localizable", "repeatPassword", fallback: #"Repeat password"#)
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
