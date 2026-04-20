// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum ConfirmPassword {
    /// Confirm Password
    internal static let placeholder = L10n.tr("Localizable", "confirm_password.placeholder", fallback: "Confirm Password")
  }
  internal enum Error {
    /// OK
    internal static let action = L10n.tr("Localizable", "error.action", fallback: "OK")
    /// Retry
    internal static let retry = L10n.tr("Localizable", "error.retry", fallback: "Retry")
    /// Error
    internal static let title = L10n.tr("Localizable", "error.title", fallback: "Error")
  }
  internal enum Password {
    /// Password
    internal static let placeholder = L10n.tr("Localizable", "password.placeholder", fallback: "Password")
  }
  internal enum SignIn {
    /// Sign In
    internal static let action = L10n.tr("Localizable", "sign_in.action", fallback: "Sign In")
    /// Localizable.strings
    ///   expense-app
    /// 
    ///   Created by Juan Olivera on 10/4/26.
    internal static let title = L10n.tr("Localizable", "sign_in.title", fallback: "Keep your expenses on point.")
    internal enum Secondary {
      /// I don't have an account
      internal static let action = L10n.tr("Localizable", "sign_in.secondary.action", fallback: "I don't have an account")
    }
  }
  internal enum SignUp {
    /// Sign Up
    internal static let action = L10n.tr("Localizable", "sign_up.action", fallback: "Sign Up")
    /// Create your account.
    internal static let title = L10n.tr("Localizable", "sign_up.title", fallback: "Create your account.")
  }
  internal enum Username {
    /// Username
    internal static let placeholder = L10n.tr("Localizable", "username.placeholder", fallback: "Username")
  }
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
