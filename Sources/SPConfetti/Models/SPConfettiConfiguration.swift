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
 SPConfetti: Configuration interface.
 
 Use this for change default values.
 */
public class SPConfettiConfiguration {
    
    // MARK: - Public
    
    /**
     SPConfetti: Position and size of emitter of particles.
     */
    public static var animation: SPConfettiAnimation {
        get { shared.animation }
        set { shared.animation = newValue }
    }
    
    /**
     SPConfetti: Style of particles. You can set custom image.
     */
    public static var particles: [SPConfettiParticle] {
        get { shared.particles }
        set { shared.particles = newValue }
    }
    
    /**
     SPConfetti: Config of particles.
     */
    public static var particlesConfig: SPConfettiParticlesConfig {
        get { shared.particlesConfig }
        set { shared.particlesConfig = newValue }
    }

    // MARK: - Internal
    
    private var animation: SPConfettiAnimation = .fullWidthToDown
    private var particles: [SPConfettiParticle] = [.arc]
    private var particlesConfig = SPConfettiParticlesConfig()
    
    // MARK: - Singltone
    
    private static let shared = SPConfettiConfiguration()
    private init() {}
}
