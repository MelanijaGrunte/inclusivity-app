//
//  UIImage.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 21/05/2020.
//  Copyright © 2020 makit. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    // https://stackoverflow.com/a/28517867
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // https://stackoverflow.com/a/29998141/9385192
    func colorDeficiencyFilter(type colofDeficiency: ColorDeficiency) -> UIImage {
        let inImage = CIImage(image: self)
        
        let rVector = colofDeficiency.matrix.rVector
        let gVector = colofDeficiency.matrix.gVector
        let bVector = colofDeficiency.matrix.bVector
        let aVector = colofDeficiency.matrix.aVector
        
        let colorMatrix = CIFilter(name: "CIColorMatrix")
        
        if colorMatrix != nil {
            colorMatrix?.setDefaults()
            colorMatrix?.setValue(inImage, forKey: kCIInputImageKey)
            colorMatrix?.setValue(rVector, forKey: "inputRVector")
            colorMatrix?.setValue(gVector, forKey: "inputGVector")
            colorMatrix?.setValue(bVector, forKey: "inputBVector")
            colorMatrix?.setValue(aVector, forKey: "inputAVector")
            
            if let output = colorMatrix?.outputImage, let cgImage = CIContext().createCGImage(output, from: output.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return self
    }
}
