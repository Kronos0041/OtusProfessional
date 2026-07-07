// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum Animechan {
    internal enum Error {
      /// Too many requests to Animechan. Wait a bit and try refreshing the list.
      internal static let rateLimited = Strings.tr("Localizable", "animechan.error.rateLimited", fallback: "Too many requests to Animechan. Wait a bit and try refreshing the list.")
      /// Animechan returned an unexpected response code: %d.
      internal static func unexpectedStatusCode(_ p1: Int) -> String {
        return Strings.tr("Localizable", "animechan.error.unexpectedStatusCode", p1, fallback: "Animechan returned an unexpected response code: %d.")
      }
    }
  }
  internal enum Common {
    /// Cancel
    internal static let cancel = Strings.tr("Localizable", "common.cancel", fallback: "Cancel")
    /// OK
    internal static let ok = Strings.tr("Localizable", "common.ok", fallback: "OK")
  }
  internal enum MockQuotes {
    internal enum Error {
      /// MockAnimechanQuotes.json file not found.
      internal static let missingFile = Strings.tr("Localizable", "mockQuotes.error.missingFile", fallback: "MockAnimechanQuotes.json file not found.")
    }
  }
  internal enum Quotes {
    /// Animechan
    internal static let title = Strings.tr("Localizable", "quotes.title", fallback: "Animechan")
    internal enum Action {
      /// Add request
      internal static let addRequest = Strings.tr("Localizable", "quotes.action.addRequest", fallback: "Add request")
    }
    internal enum Category {
      /// Category
      internal static let title = Strings.tr("Localizable", "quotes.category.title", fallback: "Category")
    }
    internal enum Detail {
      /// Quote
      internal static let title = Strings.tr("Localizable", "quotes.detail.title", fallback: "Quote")
    }
    internal enum Dialog {
      internal enum Placeholder {
        /// For example, Naruto
        internal static let anime = Strings.tr("Localizable", "quotes.dialog.placeholder.anime", fallback: "For example, Naruto")
        /// For example, Saitama
        internal static let character = Strings.tr("Localizable", "quotes.dialog.placeholder.character", fallback: "For example, Saitama")
      }
      internal enum Title {
        /// Enter anime
        internal static let anime = Strings.tr("Localizable", "quotes.dialog.title.anime", fallback: "Enter anime")
        /// Enter character
        internal static let character = Strings.tr("Localizable", "quotes.dialog.title.character", fallback: "Enter character")
      }
    }
    internal enum Error {
      /// Enter a value for the request.
      internal static let emptyQuery = Strings.tr("Localizable", "quotes.error.emptyQuery", fallback: "Enter a value for the request.")
      /// Failed to load quotes
      internal static let loadFailed = Strings.tr("Localizable", "quotes.error.loadFailed", fallback: "Failed to load quotes")
    }
    internal enum Footer {
      /// No more quotes in this category.
      internal static let noMoreQuotes = Strings.tr("Localizable", "quotes.footer.noMoreQuotes", fallback: "No more quotes in this category.")
    }
    internal enum Query {
      /// Request: anime=%@
      internal static func anime(_ p1: Any) -> String {
        return Strings.tr("Localizable", "quotes.query.anime", String(describing: p1), fallback: "Request: anime=%@")
      }
      /// Request: character=%@
      internal static func character(_ p1: Any) -> String {
        return Strings.tr("Localizable", "quotes.query.character", String(describing: p1), fallback: "Request: character=%@")
      }
    }
    internal enum Rubric {
      /// By anime
      internal static let anime = Strings.tr("Localizable", "quotes.rubric.anime", fallback: "By anime")
      /// By character
      internal static let character = Strings.tr("Localizable", "quotes.rubric.character", fallback: "By character")
    }
    internal enum Subtitle {
      /// Tap + to set a request
      internal static let empty = Strings.tr("Localizable", "quotes.subtitle.empty", fallback: "Tap + to set a request")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
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
