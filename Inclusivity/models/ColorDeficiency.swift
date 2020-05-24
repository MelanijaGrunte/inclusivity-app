//
//  ColorDeficiency.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 21/05/2020.
//  Copyright © 2020 makit. All rights reserved.
//

import Foundation
import UIKit

// https://gist.github.com/Lokno/df7c3bfdc9ad32558bb7
public enum ColorDeficiency: String, CaseIterable {
    case protanopia, protanomaly, deuteranopia, deuteranomaly, tritanopia, tritanomaly, achromatopsia, achromatomaly
    
    var matrix: (rVector: CIVector, gVector: CIVector, bVector: CIVector, aVector: CIVector) {
        switch self {
        case .protanopia: return (
            CIVector(x: 0.567, y: 0.433, z: 0, w: 0),
            CIVector(x: 0.558, y: 0.442, z: 0, w: 0),
            CIVector(x: 0, y: 0.242, z: 0.758, w: 0),
            CIVector(x: 0, y: 0, z: 0, w: 1)
        ) // 0.567 0.433 0 0 0      0.558 0.442 0 0 0          0 0.242 0.758 0 0          0 0 0 1 0
        case .protanomaly: return (
            CIVector(x: 0.817, y: 0.183, z: 0, w: 0),
            CIVector(x: 0.333, y: 0.667, z: 0, w: 0),
            CIVector(x: 0, y: 0.125, z: 0.875, w: 0),
            CIVector(x: 0, y: 0, z: 0, w: 1)
        ) // 0.817 0.183 0 0 0      0.333 0.667 0 0 0          0 0.125 0.875 0 0          0 0 0 1 0
        case .deuteranopia: return (
            CIVector(x: 0.625, y: 0.375, z: 0, w: 0),
            CIVector(x: 0.7, y: 0.3, z: 0, w: 0),
            CIVector(x: 0, y: 0.3, z: 0.7, w: 0),
            CIVector(x: 0, y: 0, z: 0, w: 1)
        ) // 0.625 0.375 0 0 0      0.7 0.3 0 0 0              0 0.3 0.7 0 0              0 0 0 1 0
        case .deuteranomaly: return (
            CIVector(x: 0.8, y: 0.2, z: 0, w: 0),
            CIVector(x: 0.258, y: 0.742, z: 0, w: 0),
            CIVector(x: 0, y: 0.142, z: 0.858, w: 0),
            CIVector(x: 0, y: 0, z: 0, w: 1)
        ) // 0.8 0.2 0 0 0          0.258 0.742 0 0 0          0 0.142 0.858 0 0          0 0 0 1 0
        case .tritanopia: return (
            CIVector(x: 0.95, y: 0.05, z: 0, w: 0),
            CIVector(x: 0, y: 0.433, z: 0.567, w: 0),
            CIVector(x: 0, y: 0.475, z: 0.525, w: 0),
            CIVector(x: 0, y: 0, z: 0, w: 1)
        ) // 0.95 0.05 0 0 0          0 0.433 0.567 0 0          0 0.475 0.525 0 0          0 0 0 1 0
        case .tritanomaly: return (
            CIVector(x: 0.967, y: 0.033, z: 0, w: 0),
            CIVector(x: 0, y: 0.733, z: 0.267, w: 0),
            CIVector(x: 0, y: 0.183, z: 0.817, w: 0),
            CIVector(x: 0, y: 0, z: 0, w: 1)
        ) // 0.967 0.033 0 0 0      0 0.733 0.267 0 0          0 0.183 0.817 0 0          0 0 0 1 0
        case .achromatopsia: return (
            CIVector(x: 0.299, y: 0.587, z: 0.114, w: 0),
            CIVector(x: 0.299, y: 0.587, z: 0.114, w: 0),
            CIVector(x: 0.299, y: 0.587, z: 0.114, w: 0),
            CIVector(x: 0, y: 0, z: 0, w: 1)
        ) // 0.299 0.587 0.114 0 0  0.299 0.587 0.114 0 0      0.299 0.587 0.114 0 0      0 0 0 1 0
        case .achromatomaly: return (
            CIVector(x: 0.618, y: 0.320, z: 0.163, w: 0),
            CIVector(x: 0.163, y: 0.775, z: 0.062, w: 0),
            CIVector(x: 0.163, y: 0.320, z: 0.516, w: 0),
            CIVector(x: 0, y: 0, z: 0, w: 1)
            ) // 0.618 0.320 0.062 0 0  0.163 0.775 0.062 0 0      0.163 0.320 0.516 0 0      0 0 0 1 0
        }
    }
}
