// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: Any> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: Any> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal protocol SegueType: RawRepresentable { }

internal extension UIViewController {
  func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    let identifier = segue.rawValue
    performSegue(withIdentifier: identifier, sender: sender)
  }
}

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum EventDetails: StoryboardType {
    internal static let storyboardName = "EventDetails"

    internal static let initialScene = InitialSceneType<EventsBy.EventDetailView>(storyboard: EventDetails.self)

    internal static let eventDetailView = SceneType<EventsBy.EventDetailView>(storyboard: EventDetails.self, identifier: "EventDetailView")
  }
  internal enum Events: StoryboardType {
    internal static let storyboardName = "Events"

    internal static let initialScene = InitialSceneType<UINavigationController>(storyboard: Events.self)

    internal static let eventListView = SceneType<EventsBy.EventListView>(storyboard: Events.self, identifier: "EventListView")
  }
  internal enum Home: StoryboardType {
    internal static let storyboardName = "Home"

    internal static let initialScene = InitialSceneType<EventsBy.HomeView>(storyboard: Home.self)
  }
  internal enum Login: StoryboardType {
    internal static let storyboardName = "Login"

    internal static let initialScene = InitialSceneType<EventsBy.LoginView>(storyboard: Login.self)
  }
  internal enum Map: StoryboardType {
    internal static let storyboardName = "Map"

    internal static let initialScene = InitialSceneType<UINavigationController>(storyboard: Map.self)

    internal static let mapView = SceneType<EventsBy.MapView>(storyboard: Map.self, identifier: "MapView")
  }
  internal enum Profile: StoryboardType {
    internal static let storyboardName = "Profile"

    internal static let initialScene = InitialSceneType<UINavigationController>(storyboard: Profile.self)

    internal static let profileView = SceneType<EventsBy.ProfileView>(storyboard: Profile.self, identifier: "ProfileView")
  }
}

internal enum StoryboardSegue {
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

private final class BundleToken {}
