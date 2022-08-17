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
  /// Ok
  internal static let errorAcceptButton = L10n.tr("Localizable", "errorAcceptButton", fallback: #"Ok"#)
  /// Ups! Something went wrong 🥲
  internal static let errorMessage = L10n.tr("Localizable", "errorMessage", fallback: #"Ups! Something went wrong 🥲"#)
  /// Error
  internal static let errorTitle = L10n.tr("Localizable", "errorTitle", fallback: #"Error"#)
  /// Name
  internal static let name = L10n.tr("Localizable", "name", fallback: #"Name"#)
  /// ******
  internal static let passPlaceholder = L10n.tr("Localizable", "passPlaceholder", fallback: #"******"#)
  /// Password
  internal static let password = L10n.tr("Localizable", "password", fallback: #"Password"#)
  /// Email already taken
  internal static let registerErrorCode1 = L10n.tr("Localizable", "registerErrorCode1", fallback: #"Email already taken"#)
  /// Register
  internal static let registerTitle = L10n.tr("Localizable", "registerTitle", fallback: #"Register"#)
  /// Repeat password
  internal static let repeatPassword = L10n.tr("Localizable", "repeatPassword", fallback: #"Repeat password"#)
  /// Welcome
  internal static let welcome = L10n.tr("Localizable", "welcome", fallback: #"Welcome"#)
  /// Welcome to the family! You can login now with your credentials.
  internal static let welcomeMessage = L10n.tr("Localizable", "welcomeMessage", fallback: #"Welcome to the family! You can login now with your credentials."#)
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
