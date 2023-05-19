//
//  CompatibleAnimationView.swift
//  Lottie_iOS
//
//  Created by Tyler Hedrick on 3/6/19.
//

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)
import UIKit

/// An Objective-C compatible wrapper around Lottie's Animation class.
/// Use in tandem with CompatibleAnimationView when using Lottie in Objective-C
@objc
public final class CompatibleAnimation: NSObject {

  // MARK: Lifecycle

  @objc
  public init(
    name: String,
    subdirectory: String? = nil,
    bundle: Bundle = Bundle.main)
  {
    self.name = name
    self.subdirectory = subdirectory
    self.bundle = bundle
    super.init()
  }

  // MARK: Internal

  internal var animation: LottieAnimation? {
    LottieAnimation.named(name, bundle: bundle, subdirectory: subdirectory)
  }

  @objc
  static func named(_ name: String) -> CompatibleAnimation {
    CompatibleAnimation(name: name)
  }

  // MARK: Private

  private let name: String
  private let subdirectory: String?
  private let bundle: Bundle
}

/// An Objective-C compatible wrapper around Lottie's RenderingEngineOption enum. Pass in an option
/// to the CompatibleAnimationView initializers to configure the rendering engine for the view.
@objc
public enum CompatibleRenderingEngineOption: Int {
  /// Uses the rendering engine specified in LottieConfiguration.shared.
  case shared

  /// Uses the library default rendering engine, coreAnimation.
  case defaultEngine

  /// Optimizes rendering performance by using the Core Animation rendering engine for animations it
  /// can render while falling back to the main thread renderer for all other animations.
  case automatic

  /// Only renders animations using the main thread rendering engine.
  case mainThread

  /// Only renders animations using the Core Animation rendering engine. Those animations that use
  /// features not yet supported on this renderer will not be rendered.
  case coreAnimation

  // MARK: Public

  /// Converts a CompatibleRenderingEngineOption to the corresponding LottieConfiguration for
  /// internal rendering engine configuration.
  public static func generateLottieConfiguration(
    _ configuration: CompatibleRenderingEngineOption)
    -> LottieConfiguration
  {
    switch configuration {
    case .shared:
      return LottieConfiguration.shared
    case .defaultEngine:
      return LottieConfiguration(renderingEngine: .coreAnimation)
    case .automatic:
      return LottieConfiguration(renderingEngine: .automatic)
    case .mainThread:
      return LottieConfiguration(renderingEngine: .mainThread)
    case .coreAnimation:
      return LottieConfiguration(renderingEngine: .coreAnimation)
    }
  }
}

/// An Objective-C compatible version of `LottieBackgroundBehavior`.
@objc
public enum CompatibleBackgroundBehavior: Int {
  /// Stop the animation and reset it to the beginning of its current play time. The completion block is called.
  case stop

  /// Pause the animation in its current state. The completion block is called.
  case pause

  /// Pause the animation and restart it when the application moves to the foreground.
  /// The completion block is stored and called when the animation completes.
  ///  - This is the default when using the Main Thread rendering engine.
  case pauseAndRestore

  /// Stops the animation and sets it to the end of its current play time. The completion block is called.
  case forceFinish

  /// The animation continues playing in the background.
  ///  - This is the default when using the Core Animation rendering engine.
  ///    Playing an animation using the Core Animation engine doesn't come with any CPU overhead,
  ///    so using `.continuePlaying` avoids the need to stop and then resume the animation
  ///    (which does come with some CPU overhead).
  ///  - This mode should not be used with the Main Thread rendering engine.
  case continuePlaying
}

/// An Objective-C compatible wrapper around Lottie's LottieAnimationView.
@objc
public final class CompatibleAnimationView: UIView {

  // MARK: Lifecycle

  /// Initializes a compatible AnimationView with a given compatible animation. Defaults to using
  /// the rendering engine specified in LottieConfiguration.shared.
  @objc
  public convenience init(compatibleAnimation: CompatibleAnimation) {
    self.init(compatibleAnimation: compatibleAnimation, compatibleRenderingEngineOption: .shared)
  }

  /// Initializes a compatible AnimationView with a given compatible animation and rendering engine
  /// configuration.
  @objc
  public init(
    compatibleAnimation: CompatibleAnimation,
    compatibleRenderingEngineOption: CompatibleRenderingEngineOption)
  {
    loadingAnimationView = LottieAnimationView(
      animation: compatibleAnimation.animation,
      configuration: CompatibleRenderingEngineOption.generateLottieConfiguration(compatibleRenderingEngineOption))
    self.compatibleAnimation = compatibleAnimation
    super.init(frame: .zero)
    commonInit()
  }

  /// Initializes a compatible AnimationView with the resources asynchronously loaded from a given
  /// URL. Defaults to using the rendering engine specified in LottieConfiguration.shared.
  @objc
  public convenience init(url: URL) {
    self.init(url: url, compatibleRenderingEngineOption: .shared)
  }

  /// Initializes a compatible AnimationView with the resources asynchronously loaded from a given
  /// URL using the given rendering engine configuration.
  @objc
  public init(url: URL, compatibleRenderingEngineOption: CompatibleRenderingEngineOption) {
    loadingAnimationView = LottieAnimationView(
      url: url,
      closure: { _ in },
      configuration: CompatibleRenderingEngineOption.generateLottieConfiguration(compatibleRenderingEngineOption))
    super.init(frame: .zero)
    commonInit()
  }

  /// Initializes a compatible AnimationView from a given Data object specifying the Lottie
  /// animation. Defaults to using the rendering engine specified in LottieConfiguration.shared.
  @objc
  public convenience init(data: Data) {
    self.init(data: data, compatibleRenderingEngineOption: .shared)
  }

  /// Initializes a compatible AnimationView from a given Data object specifying the Lottie
  /// animation using the given rendering engine configuration.
  @objc
  public init(data: Data, compatibleRenderingEngineOption: CompatibleRenderingEngineOption) {
    if let animation = try? LottieAnimation.from(data: data) {
      loadingAnimationView = LottieAnimationView(
        animation: animation,
        configuration: CompatibleRenderingEngineOption.generateLottieConfiguration(compatibleRenderingEngineOption))
    } else {
      loadingAnimationView = LottieAnimationView(
        configuration: CompatibleRenderingEngineOption.generateLottieConfiguration(compatibleRenderingEngineOption))
    }
    super.init(frame: .zero)
    commonInit()
  }

  @objc
  public override init(frame: CGRect) {
    loadingAnimationView = LottieAnimationView()
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Public

  @objc
  public var compatibleAnimation: CompatibleAnimation? {
    didSet {
      loadingAnimationView.animation = compatibleAnimation?.animation
    }
  }

  @objc
  public var loopAnimationCount: CGFloat = 0 {
    didSet {
      loadingAnimationView.loopMode = loopAnimationCount == -1 ? .loop : .repeat(Float(loopAnimationCount))
    }
  }

  @objc
  public var compatibleDictionaryTextProvider: CompatibleDictionaryTextProvider? {
    didSet {
      loadingAnimationView.textProvider = compatibleDictionaryTextProvider?.textProvider ?? DefaultTextProvider()
    }
  }

  @objc
  public override var contentMode: UIView.ContentMode {
    set { loadingAnimationView.contentMode = newValue }
    get { loadingAnimationView.contentMode }
  }

  @objc
  public var shouldRasterizeWhenIdle: Bool {
    set { loadingAnimationView.shouldRasterizeWhenIdle = newValue }
    get { loadingAnimationView.shouldRasterizeWhenIdle }
  }

  @objc
  public var currentProgress: CGFloat {
    set { loadingAnimationView.currentProgress = newValue }
    get { loadingAnimationView.currentProgress }
  }

  @objc
  public var duration: CGFloat {
    loadingAnimationView.animation?.duration ?? 0.0
  }

  @objc
  public var currentTime: TimeInterval {
    set { loadingAnimationView.currentTime = newValue }
    get { loadingAnimationView.currentTime }
  }

  @objc
  public var currentFrame: CGFloat {
    set { loadingAnimationView.currentFrame = newValue }
    get { loadingAnimationView.currentFrame }
  }

  @objc
  public var realtimeAnimationFrame: CGFloat {
    loadingAnimationView.realtimeAnimationFrame
  }

  @objc
  public var realtimeAnimationProgress: CGFloat {
    loadingAnimationView.realtimeAnimationProgress
  }

  @objc
  public var animationSpeed: CGFloat {
    set { loadingAnimationView.animationSpeed = newValue }
    get { loadingAnimationView.animationSpeed }
  }

  @objc
  public var respectAnimationFrameRate: Bool {
    set { loadingAnimationView.respectAnimationFrameRate = newValue }
    get { loadingAnimationView.respectAnimationFrameRate }
  }

  @objc
  public var isAnimationPlaying: Bool {
    loadingAnimationView.isAnimationPlaying
  }

  @objc
  public var backgroundMode: CompatibleBackgroundBehavior {
    get {
      switch loadingAnimationView.backgroundBehavior {
      case .stop:
        return .stop
      case .pause:
        return .pause
      case .pauseAndRestore:
        return .pauseAndRestore
      case .forceFinish:
        return .forceFinish
      case .continuePlaying:
        return .continuePlaying
      }
    }
    set {
      switch newValue {
      case .stop:
        loadingAnimationView.backgroundBehavior = .stop
      case .pause:
        loadingAnimationView.backgroundBehavior = .pause
      case .pauseAndRestore:
        loadingAnimationView.backgroundBehavior = .pauseAndRestore
      case .forceFinish:
        loadingAnimationView.backgroundBehavior = .forceFinish
      case .continuePlaying:
        loadingAnimationView.backgroundBehavior = .continuePlaying
      }
    }
  }

  @objc
  public func play() {
    play(completion: nil)
  }

  @objc
  public func play(completion: ((Bool) -> Void)?) {
    loadingAnimationView.play(completion: completion)
  }

  /// Note: When calling this code from Objective-C, the method signature is
  /// playFromProgress:toProgress:completion which drops the standard "With" naming convention.
  @objc
  public func play(
    fromProgress: CGFloat,
    toProgress: CGFloat,
    completion: ((Bool) -> Void)? = nil)
  {
    loadingAnimationView.play(
      fromProgress: fromProgress,
      toProgress: toProgress,
      loopMode: nil,
      completion: completion)
  }

  /// Note: When calling this code from Objective-C, the method signature is
  /// playFromFrame:toFrame:completion which drops the standard "With" naming convention.
  @objc
  public func play(
    fromFrame: CGFloat,
    toFrame: CGFloat,
    completion: ((Bool) -> Void)? = nil)
  {
    loadingAnimationView.play(
      fromFrame: fromFrame,
      toFrame: toFrame,
      loopMode: nil,
      completion: completion)
  }

  /// Note: When calling this code from Objective-C, the method signature is
  /// playFromMarker:toMarker:completion which drops the standard "With" naming convention.
  @objc
  public func play(
    fromMarker: String,
    toMarker: String,
    completion: ((Bool) -> Void)? = nil)
  {
    loadingAnimationView.play(
      fromMarker: fromMarker,
      toMarker: toMarker,
      completion: completion)
  }

  @objc
  public func play(
    marker: String,
    completion: ((Bool) -> Void)? = nil)
  {
    loadingAnimationView.play(
      marker: marker,
      completion: completion)
  }

  @objc
  public func stop() {
    loadingAnimationView.stop()
  }

  @objc
  public func pause() {
    loadingAnimationView.pause()
  }

  @objc
  public func reloadImages() {
    loadingAnimationView.reloadImages()
  }

  @objc
  public func forceDisplayUpdate() {
    loadingAnimationView.forceDisplayUpdate()
  }

  @objc
  public func getValue(
    for keypath: CompatibleAnimationKeypath,
    atFrame: CGFloat)
    -> Any?
  {
    loadingAnimationView.getValue(
      for: keypath.animationKeypath,
      atFrame: atFrame)
  }

  @objc
  public func logHierarchyKeypaths() {
    loadingAnimationView.logHierarchyKeypaths()
  }

  @objc
  public func setColorValue(_ color: UIColor, forKeypath keypath: CompatibleAnimationKeypath) {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0

    let colorspace = LottieConfiguration.shared.colorSpace

    let convertedColor = color.cgColor.converted(to: colorspace, intent: .defaultIntent, options: nil)

    if let components = convertedColor?.components, components.count == 4 {
      red = components[0]
      green = components[1]
      blue = components[2]
      alpha = components[3]
    } else {
      color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }

    let valueProvider = ColorValueProvider(LottieColor(r: Double(red), g: Double(green), b: Double(blue), a: Double(alpha)))
    loadingAnimationView.setValueProvider(valueProvider, keypath: keypath.animationKeypath)
  }

  @objc
  public func getColorValue(for keypath: CompatibleAnimationKeypath, atFrame: CGFloat) -> UIColor? {
    let value = loadingAnimationView.getValue(for: keypath.animationKeypath, atFrame: atFrame)
    guard let colorValue = value as? LottieColor else {
      return nil;
    }

    return UIColor(
      red: CGFloat(colorValue.r),
      green: CGFloat(colorValue.g),
      blue: CGFloat(colorValue.b),
      alpha: CGFloat(colorValue.a))
  }

  @objc
  public func addSubview(
    _ subview: AnimationSubview,
    forLayerAt keypath: CompatibleAnimationKeypath)
  {
    loadingAnimationView.addSubview(
      subview,
      forLayerAt: keypath.animationKeypath)
  }

  @objc
  public func convert(
    rect: CGRect,
    toLayerAt keypath: CompatibleAnimationKeypath?)
    -> CGRect
  {
    loadingAnimationView.convert(
      rect,
      toLayerAt: keypath?.animationKeypath) ?? .zero
  }

  @objc
  public func convert(
    point: CGPoint,
    toLayerAt keypath: CompatibleAnimationKeypath?)
    -> CGPoint
  {
    loadingAnimationView.convert(
      point,
      toLayerAt: keypath?.animationKeypath) ?? .zero
  }

  @objc
  public func progressTime(forMarker named: String) -> CGFloat {
    loadingAnimationView.progressTime(forMarker: named) ?? 0
  }

  @objc
  public func frameTime(forMarker named: String) -> CGFloat {
    loadingAnimationView.frameTime(forMarker: named) ?? 0
  }

  @objc
  public func durationFrameTime(forMarker named: String) -> CGFloat {
    loadingAnimationView.durationFrameTime(forMarker: named) ?? 0
  }

  // MARK: Private

  private let loadingAnimationView: LottieAnimationView

  private func commonInit() {
    setUpViews()
  }

  private func setUpViews() {
    loadingAnimationView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(loadingAnimationView)
    loadingAnimationView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    loadingAnimationView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    loadingAnimationView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    loadingAnimationView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
}

/// An Objective-C compatible wrapper around Lottie's DictionaryTextProvider.
/// Use in tandem with CompatibleAnimationView to supply text to LottieAnimationView
/// when using Lottie in Objective-C.
@objc
public final class CompatibleDictionaryTextProvider: NSObject {

  // MARK: Lifecycle

  @objc
  public init(values: [String: String]) {
    self.values = values
    super.init()
  }

  // MARK: Internal

  internal var textProvider: AnimationTextProvider? {
    DictionaryTextProvider(values)
  }

  // MARK: Private

  private let values: [String: String]
}
#endif
