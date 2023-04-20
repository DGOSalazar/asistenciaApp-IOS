//
//  UIView.swift
//  Asistencia Bancoppel
//
//  Created by MacBook Pro on 20/04/23.
//

import Foundation
import UIKit


extension UIView {
    private static let rotatingAnimationKey = "rotatingAnimation"
    
    func startRotateAnimation(direction: Int, duration: Double = 1) {
        DispatchQueue.main.async {
            guard self.layer.animation(forKey: UIView.rotatingAnimationKey) == nil else {
                return
            }
            
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.fromValue = 0.0
            animation.toValue = ((Float.pi * 2.0) * (direction > 0 ? 1 : -1))
            animation.duration = duration
            animation.repeatCount = .infinity

            self.layer.add(animation, forKey: UIView.rotatingAnimationKey)
        }
    }
    
    func stopRotateAnimation() {
        DispatchQueue.main.async {
            guard self.layer.animation(forKey: UIView.rotatingAnimationKey) != nil else {
                return
            }
            self.layer.removeAnimation(forKey: UIView.rotatingAnimationKey)
        }
    }
}
