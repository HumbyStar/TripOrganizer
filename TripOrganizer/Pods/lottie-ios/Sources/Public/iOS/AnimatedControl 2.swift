//
//  AnimatedControl.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 2/4/19.
//

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)
import UIKit

/// Lottie comes prepacked with a two Animated Controls, `AnimatedSwitch` and
/// `AnimatedButton`. Both of these controls are built on top of `AnimatedControl`
///
/// `AnimatedControl` is a subclass of `UIControl` that provides an interactive
/// mechanism for controlling the visual state of an animation in response to
/// user actions.
///
/// The `AnimatedControl` will show and hide layers depending on the current
/// `UIControl.State` of the control.
///
/// Users of `AnimationControl` can set a Layer Name for each `UIControl.State`.
/// When the state is change the `AnimationControl` will change the visibility
/// of its layers.
///
/// NOTE: Do not initialize directly. This is intended to be subclassed.
open class AnimatedControl: UIControl {

  // MARK: Lifecycle

  // MARK: Initializers

  public init(
    animation: LottieAnimation,
    configuration: LottieConfiguration = .shared)
  {
    loadingAnimationView = LottieAnimationView(
      animation: animation,
      configuration: configuration)

    super.init(frame: animation.bounds)
    commonInit()
  }

  public init() {
    loadingAnimationView = LottieAnimationView()
    super.init(frame: .zero)
    commonInit()
  }

  required public init?(coder aDecoder: NSCoder) {
    loadingAnimationView = LottieAnimationView()
    super.init(coder: aDecoder)
    commonInit()
  }

  // MARK: Open

  // MARK: UIControl Overrides

  open override var isEnabled: Bool {
    didSet {
      updateForState()
    }
  }

  open override var isSelected: Bool {
    didSet {
      updateForState()
    }
  }

  open override var isHighlighted: Bool {
    didSet {
      updateForState()
    }
  }

  open override var intrinsicContentSize: CGSize {
    loadingAnimationView.intrinsicContentSize
  }

  open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    updateForState()
    return super.beginTracking(touch, with: event)
  }

  open override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    updateForState()
    return super.continueTracking(touch, with: event)
  }

  open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    updateForState()
    return super.endTracking(touch, with: event)
  }

  open override func cancelTracking(with event: UIEvent?) {
    updateForState()
    super.cancelTracking(with: event)
  }

  open func animationDidSet() { }

  // MARK: Public

  /// The animation view in which the animation is rendered.
  public let loadingAnimationView: LottieAnimationView

  /// The animation backing the animated control.
  public var animation: LottieAnimation? {
    didSet {
      loadingAnimationView.animation = animation
      loadingAnimationView.bounds = animation?.bounds ?? .zero
      setNeedsLayout()
      updateForState()
      animationDidSet()
    }
  }

  /// The speed of the animation playback. Defaults to 1
  public var animationSpeed: CGFloat {
    set { loadingAnimationView.animationSpeed = newValue }
    get { loadingAnimationView.animationSpeed }
  }

  /// Sets which Animation Layer should be visible for the given state.
  public func setLayer(named: String, forState: UIControl.State) {
    stateMap[forState.rawValue] = named
    updateForState()
  }

  /// Sets a ValueProvider for the specified keypath
  public func setValueProvider(_ valueProvider: AnyValueProvider, keypath: AnimationKeypath) {
    loadingAnimationView.setValueProvider(valueProvider, keypath: keypath)
  }

  // MARK: Internal

  var stateMap: [UInt: String] = [:]

  func updateForState() {
    guard let animationLayer = loadingAnimationView.animationLayer else { return }
    if
      let layerName = stateMap[state.rawValue],
      let stateLayer = animationLayer.layer(for: AnimationKeypath(keypath: layerName))
    {
      for layer in animationLayer._animationLayers {
        layer.isHidden = true
      }
      stateLayer.isHidden = false
    } else {
      for layer in animationLayer._animationLayers {
        layer.isHidden = false
      }
    }
  }

  // MARK: Private

  private func commonInit() {
    loadingAnimationView.clipsToBounds = false
    clipsToBounds = true
    loadingAnimationView.translatesAutoresizingMaskIntoConstraints = false
    loadingAnimationView.backgroundBehavior = .forceFinish
    addSubview(loadingAnimationView)
    loadingAnimationView.contentMode = .scaleAspectFit
    loadingAnimationView.isUserInteractionEnabled = false
    loadingAnimationView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    loadingAnimationView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    loadingAnimationView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    loadingAnimationView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
}
#endif
