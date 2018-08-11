// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {

  internal enum Common {

    internal enum Menu {

      internal enum Button {
        /// MENU
        internal static let title = L10n.tr("Localizable", "common.menu.button.title")
      }
    }
  }

  internal enum EventDetails {

    internal enum Button {
      /// I'm not going!
      internal static let alreadyParticipate = L10n.tr("Localizable", "event-details.button.already_participate")
      /// I'm in!
      internal static let wantParticipate = L10n.tr("Localizable", "event-details.button.want-participate")
    }

    internal enum Message {
      /// Participant added!
      internal static let participantAdded = L10n.tr("Localizable", "event-details.message.participant-added")
      /// You're already participate in the event!
      internal static let participantAlreadyExists = L10n.tr("Localizable", "event-details.message.participant-already-exists")
      /// User isn't participating in this event
      internal static let participantNotInEvent = L10n.tr("Localizable", "event-details.message.participant-not-in-event")
      /// Participant removed!
      internal static let participantRemoved = L10n.tr("Localizable", "event-details.message.participant-removed")
    }

    internal enum Title {
      /// Email
      internal static let email = L10n.tr("Localizable", "event-details.title.email")
      /// Organaizer
      internal static let organaizer = L10n.tr("Localizable", "event-details.title.organaizer")
      /// Participants (%d)
      internal static func participants(_ p1: Int) -> String {
        return L10n.tr("Localizable", "event-details.title.participants", p1)
      }
      /// Website
      internal static let website = L10n.tr("Localizable", "event-details.title.website")
    }
  }

  internal enum EventList {
    /// Events
    internal static let title = L10n.tr("Localizable", "event-list.title")
  }

  internal enum Login {

    internal enum Form {
      /// Password
      internal static let password = L10n.tr("Localizable", "login.form.password")
      /// Username
      internal static let username = L10n.tr("Localizable", "login.form.username")
    }

    internal enum Message {
      /// Incorrect username or password. Please try again
      internal static let invalidCredentials = L10n.tr("Localizable", "login.message.invalid-credentials")
      /// You have successfully logged in!
      internal static let success = L10n.tr("Localizable", "login.message.success")
    }
  }

  internal enum Profile {
    /// Profile
    internal static let title = L10n.tr("Localizable", "profile.title")
  }

  internal enum TabBar {
    /// Events
    internal static let events = L10n.tr("Localizable", "tab-bar.events")
    /// Map
    internal static let map = L10n.tr("Localizable", "tab-bar.map")
    /// Profile
    internal static let profile = L10n.tr("Localizable", "tab-bar.profile")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
