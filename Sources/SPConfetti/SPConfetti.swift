// The MIT License (MIT)
// Copyright © 2021 Ivan Vorobei (hello@ivanvorobei.by)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

/**
 SPConfetti: Acess level. Here you get ready-use methods.
 Recomended use it.
 */
public class SPConfetti {
    
    /**
     SPConfetti: Flag for detect if confetti making now.
     */
    public static var isReleasesParticles: Bool {
        return shared.view.isReleasesParticles
    }
    
    /**
     SPConfetti: Start animating with selected animation and particles style.
     
     - parameter animation: Kind of animation, position and direction of particles.
     - parameter particles: Particles style. Can be custom image.
     - parameter window: The targe window. Use key window if `nil`.
     */
    @available(iOSApplicationExtension, unavailable)
    public static func startAnimating(_ animation: SPConfettiAnimation, particles: [SPConfettiParticle], in window: UIWindow? = nil) {
        shared.view.animation = animation
        shared.view.particles = particles
        guard let window = window ?? UIApplication.shared.keyWindow else { return }
        if let superview = shared.view.superview, superview == window {
            superview.bringSubviewToFront(shared.view)
        } else {
            window.addSubview(shared.view)
        }
        shared.view.frame = window.bounds
        shared.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        shared.view.startAnimating()
    }
    
    /**
     SPConfetti: Start animating with selected animation and particles style.
     
     - parameter animation: Kind of animation, position and direction of particles.
     - parameter particles: Particles style. Can be custom image.
     - parameter duration: Automatically stop animation after this time interval.
     - parameter window: The targe window. Use key window if `nil`.
     */
    @available(iOSApplicationExtension, unavailable)
    public static func startAnimating(_ animation: SPConfettiAnimation, particles: [SPConfettiParticle], duration: TimeInterval, in window: UIWindow? = nil) {
        startAnimating(animation, particles: particles, in: window)
        delay(duration, closure: {
            stopAnimating()
        })
    }
    
    /**
     SPConfetti: Stop current animation.
     */
    public static func stopAnimating() {
        shared.view.stopAnimating()
    }
    
    // MARK: - Internal
    
    let view = SPConfettiView()
    
    // MARK: - Singltone
    
    private static let shared = SPConfetti()
    private init() {}
}
