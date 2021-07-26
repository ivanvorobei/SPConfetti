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
import SparrowKit
import SPDiffable
import SPConfetti

class PreviewController: SPDiffableTableController {
    
    let confettiView = SPConfettiView()
    
    // MARK: - Data
    
    private var currentParticles: SPConfettiParticles = .arc {
        willSet {
            let cell = diffableDataSource?.cell(UITableViewCell.self, for: currentParticles.id)
            cell?.accessoryType = .none
        }
        didSet {
            let cell = diffableDataSource?.cell(UITableViewCell.self, for: currentParticles.id)
            cell?.accessoryType = .checkmark
        }
    }
    
    private var currentAnimation: SPConfettiAnimation = .fullWidthToDown {
        willSet {
            let cell = diffableDataSource?.cell(UITableViewCell.self, for: currentAnimation.id)
            cell?.accessoryType = .none
        }
        didSet {
            let cell = diffableDataSource?.cell(UITableViewCell.self, for: currentAnimation.id)
            cell?.accessoryType = .checkmark
        }
    }
    
    // MARK: - Init
    
    init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SPConfetti"
        view.addSubview(confettiView)
        configureSwitchNavigationBarButtonItem()
        
        let particles = [SPConfettiParticles.arc, .star, .heart, .circle, .triangle, .polygon]
        let particlesSection = SPDiffableSection(
            identifier: "particles",
            header: SPDiffableTextHeaderFooter(text: "Particles"),
            footer: SPDiffableTextHeaderFooter(text: "Choose the style of confetti particles. Show the confetti only when the user is having fun, and if not having fun, don't show it."),
            items: particles.map({ particle in
                SPDiffableTableRow(
                    identifier: particle.id,
                    text: particle.debugName,
                    detail: nil,
                    icon: particle.image.resize(newWidth: 18).withRenderingMode(.alwaysTemplate),
                    accessoryType: (particle.id == currentParticles.id) ? .checkmark : .none,
                    selectionStyle: .none,
                    action: { [weak self] _ in
                        guard let self = self else { return }
                        self.currentParticles = particle
                    })
            })
        )
        
        let animations = SPConfettiAnimation.allCases
        let animationsSection = SPDiffableSection(
            identifier: "animations",
            header: SPDiffableTextHeaderFooter(text: "Animations"),
            footer: SPDiffableTextHeaderFooter(text: "Select the position from which the confetti is to be launched and it direction."),
            items: animations.map({ animation in
                
                let iconImage: UIImage = {
                    switch animation {
                    case .fullWidthToDown: return .system("menubar.arrow.down.rectangle")
                    case .fullWidthToUp: return .system("menubar.arrow.up.rectangle")
                    case .centerWidthToDown: return .system("arrowtriangle.down.square")
                    case .centerWidthToUp: return .system("arrowtriangle.up.square")
                    }
                }()
                
                return SPDiffableTableRow(
                    identifier: animation.id,
                    text: animation.debugName,
                    detail: nil,
                    icon: iconImage,
                    accessoryType: (animation.id == currentAnimation.id) ? .checkmark : .none,
                    selectionStyle: .none,
                    action: { [weak self] _ in
                        guard let self = self else { return }
                        self.currentAnimation = animation
                    })
            })
        )
        setCellProviders(SPDiffableTableCellProviders.default, sections: [particlesSection, animationsSection])
    }
    
    // MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        confettiView.setEqualSuperviewBounds()
    }
    
    // MARK: - Internal
    
    private func configureSwitchNavigationBarButtonItem() {
        if SPConfetti.isReleasesParticles {
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(systemItem: .pause, primaryAction: .init(handler: { [weak self] _ in
                guard let self = self else { return }
                SPConfetti.stopAnimating()
                self.configureSwitchNavigationBarButtonItem()
            }), menu: nil)
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(systemItem: .play, primaryAction: .init(handler: { [weak self] _ in
                guard let self = self else { return }
                SPConfetti.startAnimating(self.currentAnimation, particles: self.currentParticles)
                self.configureSwitchNavigationBarButtonItem()
            }), menu: nil)
        }
    }
}


