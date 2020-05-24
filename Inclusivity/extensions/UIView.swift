//
//  UIView.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 21/05/2020.
//  Copyright © 2020 makit. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func scale(by scale: CGFloat) {
        self.contentScaleFactor = scale
        for subview in self.subviews {
            subview.scale(by: scale)
        }
    }
    
    func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    // https://stackoverflow.com/a/34404432
    func copyView<T: UIView>() -> T {
        // swiftlint:disable:next force_cast
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
    // subview.snapshotView(afterScreenUpdates: true) negāja
    // subview.mutableCopy() negāja
}
