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
 SPConfetti: Particles styles.
 */
public enum SPConfettiParticle {
    
    case arc
    case star
    case heart
    case circle
    case triangle
    case polygon
    case custom(UIImage)
    
    public var id: String {
        switch self {
        case .arc: return "arc"
        case .star: return "star"
        case .heart: return "heart"
        case .circle: return "circle"
        case .triangle: return "triangle"
        case .polygon: return "polygon"
        case .custom(_): return "custom_image"
        }
    }
    
    public var debugName: String {
        switch self {
        case .arc: return "Arc"
        case .star: return "Star"
        case .heart: return "Heart"
        case .circle: return "Circle"
        case .triangle: return "Triangle"
        case .polygon: return "Polygon"
        case .custom(_): return "Custom Image"
        }
    }
    
    public var image: UIImage {
        return Images.particles_icon(for: self)
    }
}
