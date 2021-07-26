// The MIT License (MIT)
// Copyright © 2020 Ivan Vorobei (hello@ivanvorobei.by)
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
import SPConfetti

class PreviewController: SPTableViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SPConfetti"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        configureSwitchNavigationBarButtonItem()
    }
    
    // MARK: - Internal
    
    private func configureSwitchNavigationBarButtonItem() {
        if SPConfetti.isReleasesParticles {
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .pause, target: self, action: #selector(self.startAnimation))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .play, target: self, action: #selector(self.stopAnimation))
        }
    }
    
    // MARK: - Actions
    
    @objc func startAnimation() {
        SPConfetti.stopAnimating()
        self.configureSwitchNavigationBarButtonItem()
    }
    
    @objc func stopAnimation() {
        SPConfetti.startAnimating(.fullWidthToDown, particles: [SPConfettiParticle.arc, .circle, .heart, .star])
        self.configureSwitchNavigationBarButtonItem()
    }
}
