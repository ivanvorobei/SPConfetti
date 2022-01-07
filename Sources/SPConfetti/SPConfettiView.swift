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
import QuartzCore

/**
 SPConfetti: Main view. Can be customisable if need.
 
 For change emitter position and size, check property `animation`.
 You can change it after init.
 
 For change particles, set `particles`. You can set custom image.
 
 Recomended call `SPConfetti` and choose ready use method.
 If you need custom logic, use this view.
 */
open class SPConfettiView: UIView {
    
    public weak var delegate: SPConfettiDelegate?
    
    // MARK: - Layers
    
    /**
     SPConfetti: QuartzCore layer which process particles.
     */
    private var emitterLayer: CAEmitterLayer? = nil
    
    // MARK: - Init
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }
    
    public init() {
        super.init(frame: .zero)
        commomInit()
    }
    /**
     SPConfetti: Create new confetti view with custom animation and particles.
     
     - parameter animation: Kind of animation, position and direction of particles.
     - parameter particles: Particles style. Can be custom image.
     */
    public init(animation: SPConfettiAnimation, particles: [SPConfettiParticle]) {
        super.init(frame: .zero)
        self.animation = animation
        self.particles = particles
        commomInit()
    }
    
    internal func commomInit() {
        emitterLayer?.lifetime = .zero
        isUserInteractionEnabled = false
    }
    
    // MARK: - Public
    
    /**
     SPConfetti: Flag for detect if confetti making now.
     */
    public var isReleasesParticles: Bool {
        guard let emitterLayer = emitterLayer else { return false }
        return emitterLayer.lifetime != .zero
    }
    
    /**
     SPConfetti: Position and size of emitter of particles.
     
     Change it before start animating.
     */
    public lazy var animation: SPConfettiAnimation = SPConfettiConfiguration.animation
    
    /**
     SPConfetti: Style of particles. You can set custom image.
     */
    public lazy var particles: [SPConfettiParticle] = SPConfettiConfiguration.particles
    
    /**
     SPConfetti: Config of particles.
     */
    public lazy var particlesConfig = SPConfettiConfiguration.particlesConfig
    
    /**
     SPConfetti: Start animating with selected animation and particles style.
     */
    public func startAnimating() {
        if isReleasesParticles {
            print("SPConfetti - Confetti already releases. Please, call `stopAnimating` func before start new animation. For now this call don't have any effect.")
            return
        }
        let emitterLayer = CAEmitterLayer()
        emitterLayer.birthRate = 1
        emitterLayer.lifetime = .zero
        switch self.animation {
        case .fullWidthToDown:
            emitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        case .fullWidthToUp:
            emitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        case .centerWidthToDown:
            emitterLayer.emitterShape = CAEmitterLayerEmitterShape.point
        case .centerWidthToUp:
            emitterLayer.emitterShape = CAEmitterLayerEmitterShape.point
        }
        
        emitterLayer.emitterCells = []
        for color in particlesConfig.colors {
            for particle in particles {
                let cell = makeEmitterCell(particle: particle, color: color)
                emitterLayer.emitterCells?.append(cell)
            }
        }
        
        layer.addSublayer(emitterLayer)
        emitterLayer.lifetime = 1
        self.emitterLayer = emitterLayer
        delegate?.confettiDidStartAnimating?(view: self)
    }
    
    /**
     SPConfetti: Stop current animation.
     
     - parameter animatable: If animatable particles compelte its way. If none-animatable, particles dissapear at once.
     */
    public func stopAnimating(animatable: Bool = true) {
        if animatable {
            emitterLayer?.lifetime = .zero
            delegate?.confettiDidStopAnimating?(view: self)
            // Clean sublayers which not using already.
            if let time = emitterLayer?.emitterCells?.first?.lifetime {
                let layerForRemove = self.emitterLayer
                delay(TimeInterval(time + 0.5), closure: { [weak self] in
                    guard let self = self else { return }
                    layerForRemove?.removeFromSuperlayer()
                    self.delegate?.confettiDidEndAnimating?(view: self)
                })
            }
            
        } else {
            emitterLayer?.lifetime = .zero
            emitterLayer?.removeFromSuperlayer()
            delegate?.confettiDidStopAnimating?(view: self)
            delegate?.confettiDidEndAnimating?(view: self)
        }
        emitterLayer = nil
    }
    
    // MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        emitterLayer?.frame = bounds
        updateEmitterPositionAndSize()
    }
    
    /**
     SPConfetti: Update emiiter position and size.
     Usually call when updating layout, ex. rotation device.
     */
    private func updateEmitterPositionAndSize() {
        // Inset using for hide appear particles.
        // With inset it appear out of frame.
        let inset = particleWidth * (particlesConfig.contentsScale + particlesConfig.scaleRange)
        switch animation {
        case .fullWidthToDown:
            emitterLayer?.emitterPosition = CGPoint(x: frame.size.width / 2, y: -inset)
            emitterLayer?.emitterSize = CGSize(width: frame.size.width, height: .zero)
        case .fullWidthToUp:
            emitterLayer?.emitterPosition = CGPoint(x: frame.size.width / 2, y: frame.size.height + inset)
            emitterLayer?.emitterSize = CGSize(width: frame.size.width, height: .zero)
        case .centerWidthToDown:
            emitterLayer?.emitterPosition = CGPoint(x: frame.size.width / 2, y: -inset)
            emitterLayer?.emitterSize = CGSize(width: CGFloat.zero, height: .zero)
        case .centerWidthToUp:
            emitterLayer?.emitterPosition = CGPoint(x: frame.size.width / 2, y: frame.size.height + inset)
            emitterLayer?.emitterSize = CGSize(width: CGFloat.zero, height: .zero)
        }
    }
    
    // MARK: - Internal
    
    /**
     SPConfetti: Wrapper of emitter cell generate.
     */
    private func makeEmitterCell(particle: SPConfettiParticle, color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = particlesConfig.birthRate / Float(particlesConfig.colors.count) / Float(particles.count)
        cell.lifetime = particlesConfig.lifetime
        cell.lifetimeRange = .zero
        cell.velocity = particlesConfig.velocity
        cell.velocityRange = particlesConfig.velocityRange
        cell.spin = particlesConfig.spin
        cell.spinRange = particlesConfig.spinRange
        cell.contentsScale = 1 / particlesConfig.contentsScale
        cell.scaleRange = particlesConfig.scaleRange
        cell.scaleSpeed = particlesConfig.scaleSpeed
        cell.beginTime = CACurrentMediaTime()
        switch self.animation {
        case .fullWidthToDown:
            cell.emissionLongitude = degressToRadians(180)
            cell.emissionRange = degressToRadians(90)
        case .fullWidthToUp:
            cell.emissionLongitude = degressToRadians(0)
            cell.emissionRange = degressToRadians(90)
        case .centerWidthToDown:
            cell.emissionLongitude = degressToRadians(90)
            cell.emissionRange = degressToRadians(45)
        case .centerWidthToUp:
            cell.emissionLongitude = degressToRadians(270)
            cell.emissionRange = degressToRadians(45)
        }
        var image = particle.image.resize(newWidth: particleWidth)
        if particlesConfig.colored {
            image = image.colored(color)
            cell.color = color.cgColor
        }
        cell.contents = image.cgImage
        
        // Make 3D
        cell.setValue("plane", forKey: "particleType")
        cell.setValue(Double.pi, forKey: "orientationRange")
        cell.setValue(Double.pi, forKey: "orientationLongitude")
        cell.setValue(Double.pi, forKey: "orientationLatitude")
        // End make 3d
        
        return cell
    }
    
    /**
     SPConfetti: Calculate particle width with screen width or height and particles factor from config.
     */
    private var particleWidth: CGFloat {
        (min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) * particlesConfig.particleSideSizeFactor
    }
    
    /**
     SPConfetti: Convert degress to radians.
     */
    private func degressToRadians(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
}
