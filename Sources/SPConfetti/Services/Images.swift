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

enum Images {
    
    static func particles_icon(for particles: SPConfettiParticle) -> UIImage {
        switch particles {
        case .arc:
            return UIImage.init(named: "arc", in: bundle, compatibleWith: nil) ?? UIImage()
        case .heart:
            return UIImage.init(named: "heart", in: bundle, compatibleWith: nil) ?? UIImage()
        case .circle:
            return UIImage.init(named: "circle", in: bundle, compatibleWith: nil) ?? UIImage()
        case .polygon:
            return UIImage.init(named: "polygon", in: bundle, compatibleWith: nil) ?? UIImage()
        case .star:
            return UIImage.init(named: "star", in: bundle, compatibleWith: nil) ?? UIImage()
        case .triangle:
            return UIImage.init(named: "triangle", in: bundle, compatibleWith: nil) ?? UIImage()
        case .custom(let image):
            return image
        }
    }
    
    // MARK: - Internal
    
    static var bundle: Bundle {
        
        // If installed via SPM, will be available bundle .module.
        
        #if SPCONFETTI_SPM
        return .module
        #else
        
        // If installed via Cocoapods, should use bundle from podspec.
        
        let path = Bundle(for: SPConfetti.self).path(forResource: "SPConfetti", ofType: "bundle") ?? ""
        let bundle = Bundle(path: path) ?? Bundle.main
        return bundle
        #endif
    }
}
