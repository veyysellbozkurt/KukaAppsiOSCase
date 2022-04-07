//
//  Extensions.swift
//  KukaAppsiOSCase
//
//  Created by Veysel Bozkurt on 8.04.2022.
//

import Foundation
import UIKit

extension UIButton {
    
    func bounceButton() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = NSNumber(value: 0.5)
        animation.duration = 0.1
        animation.repeatCount = 1
        animation.autoreverses = true
        layer.add(animation, forKey: nil)
    }
}
