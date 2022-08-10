// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// AnotherView
  internal static let anotherView = L10n.tr("Localizable", "anotherView", fallback: #"AnotherView"#)
  /// Ok
  internal static let errorAcceptButton = L10n.tr("Localizable", "errorAcceptButton", fallback: #"Ok"#)
  /// Create account
  internal static let errorCreateAccountButton = L10n.tr("Localizable", "errorCreateAccountButton", fallback: #"Create account"#)
  /// Ups! Something went wrong 🥲
  internal static let errorMessage = L10n.tr("Localizable", "errorMessage", fallback: #"Ups! Something went wrong 🥲"#)
  /// Error
  internal static let errorTitle = L10n.tr("Localizable", "errorTitle", fallback: #"Error"#)
  /// Go to %@
  internal static func goTo(_ p1: Any) -> String {
    return L10n.tr("Localizable", "goTo", String(describing: p1), fallback: #"Go to %@"#)
  }
  /// Go to the first tab
  internal static let goToFirstTab = L10n.tr("Localizable", "goToFirstTab", fallback: #"Go to the first tab"#)
  /// Login
  internal static let login = L10n.tr("Localizable", "login", fallback: #"Login"#)
  /// User not registered
  internal static let loginErrorCode1 = L10n.tr("Localizable", "loginErrorCode1", fallback: #"User not registered"#)
  /// Password does not match
  internal static let loginErrorCode2 = L10n.tr("Localizable", "loginErrorCode2", fallback: #"Password does not match"#)
  /// Unknown error
  internal static let loginErrorUnknown = L10n.tr("Localizable", "loginErrorUnknown", fallback: #"Unknown error"#)
  /// Logout
  internal static let logout = L10n.tr("Localizable", "logout", fallback: #"Logout"#)
  /// Map
  internal static let map = L10n.tr("Localizable", "map", fallback: #"Map"#)
  /// Plural format key: "%#@views@"
  internal static func nViews(_ p1: Int) -> String {
    return L10n.tr("Localizable", "nViews", p1, fallback: #"Plural format key: "%#@views@""#)
  }
  /// Pop to root
  internal static let popToRoot = L10n.tr("Localizable", "popToRoot", fallback: #"Pop to root"#)
  /// Register
  internal static let register = L10n.tr("Localizable", "register", fallback: #"Register"#)
  /// There %@ in the navigation stack
  internal static func thereAreNViewsInTheStack(_ p1: Any) -> String {
    return L10n.tr("Localizable", "thereAreNViewsInTheStack", String(describing: p1), fallback: #"There %@ in the navigation stack"#)
  }
  /// This is AnotherView
  internal static let thisIsAnotherView = L10n.tr("Localizable", "thisIsAnotherView", fallback: #"This is AnotherView"#)
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
