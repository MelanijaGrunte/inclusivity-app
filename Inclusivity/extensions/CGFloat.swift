//
//  CGFloat.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 18/04/2020.
//  Copyright © 2020 makit. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
