# SPConfetti

<p aligment="left">
    <img src="https://cdn.ivanvorobei.by/github/spconfetti/v1.4/easy-start.png?version=2" height="180"/>
    <img src="https://cdn.ivanvorobei.by/github/spconfetti/v1.4/particles.png?version=2" height="180"/>
    <img src="https://cdn.ivanvorobei.by/github/spconfetti/v1.4/directions.png?version=2" height="180"/>
</p>

A simple solution to show the confetti to the user. Smoothly starts and stops. Allow set multiply diffrent particles at once. You can change shapes and switch between styles. It is possible to change the size and position of emitter. Ready use arc, star, heart triangle shapes. You can set custom shapes with your image.

## Navigate

- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [CocoaPods](#cocoapods)
    - [Manually](#manually)
- [UIKit](#uikit)
    - [Quick Start](#uikit)
    - [Animation](#animation)
    - [Particles](#particles)
    - [Global Appearance](#global-appearance)
    - [Delegate](#delegate)
- [SwiftUI](#swiftui)
- [Russian Community](#russian-community)

## Installation

Ready for use on iOS 11+ and tvOS 11+.

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

Once you have your Swift package set up, adding as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/ivanvorobei/SPConfetti", .upToNextMajor(from: "1.4.0"))
]
```

### CocoaPods:

[CocoaPods](https://cocoapods.org) is a dependency manager. For usage and installation instructions, visit their website. To integrate using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'SPConfetti'
```

### Manually

If you prefer not to use any of dependency managers, you can integrate manually. Put `Sources/SPConfetti` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## UIKit

### Quick Start

For easy start confetti animation call this:

```swift
// For start animation
SPConfetti.startAnimating(.centerWidthToDown, particles: [.triangle, .arc])

// For stop animation
SPConfetti.stopAnimating()
```

If you want stop animation automatically in time, use it:

```swift
SPConfetti.startAnimating(.centerWidthToDown, particles: [.triangle, .arc], duration: 3)
```

You can manage by view `SPConfettiView` with custom layout if need.

### Animation

For change emitter size and direction, use `animation` property. Available next animations:

```swift
enum SPConfettiAnimation {

    case fullWidthToDown
    case fullWidthToUp
    case centerWidthToDown
    case centerWidthToUp
}

// To change animation:
confettiView.animation = .centerWidthToDown
```

### Particles

You can customise particles style and animation config.

```swift
// Available `.arc`, `.star`, `.heart`, `.circle`, `.triangle` and `.polygon`.
// You can set many styles particles.
confettiView.particles = [.star]
```

For set custom image use `.custom` case:

```swift
confettiView.particles = [.custom(yourImage)]
```

### Global Appearance

You can set global values with configuration object. It will apply for all next configuration of confetti view by default.

```swift
SPConfettiConfiguration.particles = [.star]
SPConfettiConfiguration.particlesConfig.colors = [.systemRed, .sytemBlue]
```

## Delegate

For get notification about events, set delegate for view and implement protocol `SPConfettiDelegate`: 

```swift
confettiView.delegate = self
```
Looks at protocol:

```swift
protocol SPConfettiDelegate: AnyObject {

    // Caling when animation start.
    func confettiDidStartAnimating()

    // Caling when animation stop.
    func confettiDidStopAnimating()

    // Caling when animation end. 
    // May calling after `confettiDidStopAnimating`,
    // becouse after stop emitting particles existing particles
    // still available.
    func confettiDidEndAnimating()
}
```

## SwiftUI

If you are using SwiftUI, it is recommended that you use the modifier we provide. This will ensure the confetti effects are presented within the corresponding window scene.

```swift
struct FancyButton: View {

    @State private var isPresenting = false
    
    var body: some View {
        Button("🎉 hooray!", action: { isPresenting.toggle() })
            .confetti(isPresented: $isPresenting,
                      animation: .fullWidthToDown,
                      particles: [.triangle, .arc],
                      duration: 3.0)
    }
}
```

The confetti modifier can be attached to any of the view hierarchies. It will always produce a full screen effect.

The global configuration above also works in SwiftUI. However, you can set different configurations for each confetti separately by using the `.confettiParticle(_:_:)` modifier.

```swift
VStack {
    Button("Fast", action: { isPresenting1.toggle() })
            .confetti(isPresented: $isPresenting1,
                      animation: .fullWidthToDown,
                      particles: [.triangle, .arc],
                      duration: 3.0)
            .confettiParticle(\.velocity, 600)

    Button("Slow", action: { isPresenting2.toggle() })
            .confetti(isPresented: $isPresenting2,
                      animation: .fullWidthToDown,
                      particles: [.triangle, .arc],
                      duration: 3.0)
            .confettiParticle(\.velocity, 100)
}
```

## Russian Community

Я веду [телеграм-канал](https://sparrowcode.by/telegram), там публикую новости и туториалы.<br>
С проблемой помогут [в чате](https://sparrowcode.by/telegram/chat).

Видео-туториалы выклыдываю на [YouTube](https://ivanvorobei.by/youtube):

[![Tutorials on YouTube](https://cdn.ivanvorobei.by/github/readme/youtube-preview.jpg)](https://ivanvorobei.by/youtube)
