// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias Image = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

@available(*, deprecated, renamed: "ImageAsset")
internal typealias AssetType = ImageAsset

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Colors {
    internal enum Badge {
      internal static let badgeBackground = ColorAsset(name: "badge-background")
      internal static let badgeText = ColorAsset(name: "badge-text")
    }
    internal enum Main {
      internal static let buttonNormal = ColorAsset(name: "button-normal")
      internal static let buttonSelected = ColorAsset(name: "button-selected")
      internal static let inputFieldError = ColorAsset(name: "input-field-error")
      internal static let inputFieldSeparator = ColorAsset(name: "input-field-separator")
      internal static let inputFieldTextNormal = ColorAsset(name: "input-field-text-normal")
      internal static let inputFieldTip = ColorAsset(name: "input-field-tip")
      internal static let mainBackground = ColorAsset(name: "main-background")
      internal static let primaryText = ColorAsset(name: "primary-text")
      internal static let progressHud = ColorAsset(name: "progress-hud")
      internal static let pullToRefresh = ColorAsset(name: "pull-to-refresh")
    }
    internal enum NavBar {
      internal static let navbarBackground = ColorAsset(name: "navbar-background")
      internal static let navbarButton = ColorAsset(name: "navbar-button")
      internal static let navbarTitle = ColorAsset(name: "navbar-title")
    }
    internal enum TabBar {
      internal static let tabbarIconNormal = ColorAsset(name: "tabbar-icon-normal")
      internal static let tabbarIconSelected = ColorAsset(name: "tabbar-icon-selected")
    }

    // swiftlint:disable trailing_comma
    internal static let allColors: [ColorAsset] = [
      Badge.badgeBackground,
      Badge.badgeText,
      Main.buttonNormal,
      Main.buttonSelected,
      Main.inputFieldError,
      Main.inputFieldSeparator,
      Main.inputFieldTextNormal,
      Main.inputFieldTip,
      Main.mainBackground,
      Main.primaryText,
      Main.progressHud,
      Main.pullToRefresh,
      NavBar.navbarBackground,
      NavBar.navbarButton,
      NavBar.navbarTitle,
      TabBar.tabbarIconNormal,
      TabBar.tabbarIconSelected,
    ]
    internal static let allImages: [ImageAsset] = [
    ]
    // swiftlint:enable trailing_comma
    @available(*, deprecated, renamed: "allImages")
    internal static let allValues: [AssetType] = allImages
  }
  internal enum Images {
    internal static let avatarPlaceholder = ImageAsset(name: "avatar_placeholder")
    internal static let icnAccountBox = ImageAsset(name: "icn_account_box")
    internal static let icnBack = ImageAsset(name: "icn_back")
    internal static let icnCalend = ImageAsset(name: "icn_calend")
    internal static let icnEditOutline = ImageAsset(name: "icn_edit_outline")
    internal static let icnEvent = ImageAsset(name: "icn_event")
    internal static let icnLocation = ImageAsset(name: "icn_location")
    internal static let icnMap = ImageAsset(name: "icn_map")
    internal static let icnMenu = ImageAsset(name: "icn_menu")
    internal static let profilePlaceholder = ImageAsset(name: "profile_placeholder")
    internal static let tempEventImage = ImageAsset(name: "temp_event_image")

    // swiftlint:disable trailing_comma
    internal static let allColors: [ColorAsset] = [
    ]
    internal static let allImages: [ImageAsset] = [
      avatarPlaceholder,
      icnAccountBox,
      icnBack,
      icnCalend,
      icnEditOutline,
      icnEvent,
      icnLocation,
      icnMap,
      icnMenu,
      profilePlaceholder,
      tempEventImage,
    ]
    // swiftlint:enable trailing_comma
    @available(*, deprecated, renamed: "allImages")
    internal static let allValues: [AssetType] = allImages
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

internal extension Image {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
