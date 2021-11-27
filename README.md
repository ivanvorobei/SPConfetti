<img align="left" src="https://github.com/ivanvorobei/SPConfetti/blob/main/Assets/Readme/latest-preview.jpg" width="400"/>

# SPConfetti

A simple solution to show the confetti to the user. Smoothly starts and stops. Allow set multiply diffrent particles at once.

<p float="left">
    <a href="https://opensource.ivanvorobei.by/spconfetti/preview">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/video-preview.svg">
    </a>
</p>

You can change shapes and switch between styles. It is possible to change the size and position of emitter. Ready use arc, star, heart triangle shapes. You can set custom shapes with your image.

If you like the project, don't forget to `put star ★`<br>Check out my other libraries:

<p float="left">
    <a href="https://opensource.ivanvorobei.by">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/more-libraries.svg">
    </a>
</p>

## Navigate

- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [CocoaPods](#cocoapods)
    - [Manually](#manually)
- [Quick Start](#quick-start)
- [SwiftUI](#swiftui)
- [Customise](#usage)
    - [Animation](#animation)
    - [Particles](#particles)
    - [Shared Configuration](#shared-configuration)
    - [SwiftUI Configuration](#swiftui-configuration)
- [Delegate](#delegate)
- [Сontribution](#сontribution)
- [Other Projects](#other-projects)
- [Russian Community](#russian-community)

## Installation

Ready for use on iOS & tvOS 10+. Works with Swift 5+. Required Xcode 12.0 and higher.

<img align="right" src="https://github.com/ivanvorobei/SPConfetti/blob/main/Assets/Readme/spm-install-preview.png" width="520"/>

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate using Xcode 12, specify it in `File > Swift Packages > Add Package Dependency...`:

```ogdl
https://github.com/ivanvorobei/SPConfetti
```

### CocoaPods:

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'SPConfetti'
```

### Manually

If you prefer not to use any of dependency managers, you can integrate manually. Put `Sources/ProjectName` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## Quick Start

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

## Customise

### Animation

For change emitter size and direction, use `animation` property. Now available next animations:

```swift
enum SPConfettiAnimation {

    case fullWidthToDown
    case fullWidthToUp
    case centerWidthToDown
    case centerWidthToUp
}
```

To change animation:

```swift
confettiView.animation = .centerWidthToDown
```

### Particles

You can customise particles style and animation config.

```swift
// Available arc, star, heart, circle, triangle and polygon.
// You can set many styles particles.
confettiView.particles = [.star]
```

For set custom image use `custom` case:

```swift
confettiView.particles = [.custom(yourImage)]
```

### Shared Configuration

You can set global values with configuration object. It will apply for all next configuration of confetti view by default.

```swift
// For example, available more
SPConfettiConfiguration.particles = [.star]
SPConfettiConfiguration.particlesConfig.colors = [.systemRed, .sytemBlue]
```

### SwiftUI Configuration

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

## Сontribution

My English is very bad. You can see this once you read the documentation. I would really like to have clean and nice documentation. If you see gramatical errors and can help fix the Readme, please contact me hello@ivanvorobei.by or make a Pull Request. Thank you in advance!

## Other Projects

I love being helpful. Here I have provided a list of libraries that I keep up to date. For see `video previews` of libraries without install open [opensource.ivanvorobei.by](https://opensource.ivanvorobei.by) website.<br>
I have libraries with native interface and managing permissions. Also available pack of useful extensions for boost your development process.

<p float="left">
    <a href="https://opensource.ivanvorobei.by">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/more-libraries.svg">
    </a>
        <a href="https://xcodeshop.ivanvorobei.by">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/xcode-shop.svg">
    </a>
</p>

## Russian Community

Подписывайся в телеграм-канал, если хочешь получать уведомления о новых туториалах.<br>
Со сложными и непонятными задачами помогут в чате.

<p float="left">
    <a href="https://sparrowcode.by/telegram">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/open-telegram-channel.svg">
    </a>
    <a href="https://sparrowcode.by/telegram/chat">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/russian-community-chat.svg">
    </a>
</p>

Видео-туториалы выклыдываю на [YouTube](https://ivanvorobei.by/youtube):

[![Tutorials on YouTube](https://cdn.ivanvorobei.by/github/readme/youtube-preview.jpg)](https://ivanvorobei.by/youtube)
