//
//  CustomLoader.swift
//  Asistencia Bancoppel
//
//  Created by Luis Díaz on 19/04/23.
//

import Foundation
import UIKit


class CustomLoader {
    private static var isVisible = false
    private static var backgroundView: UIView?
    private static var newLoader: UIImageView?

    
    static func show() {
        DispatchQueue.main.async {
            guard !self.isVisible else {
                return
            }
            
            self.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            self.backgroundView?.backgroundColor = GlobalConstants.BancoppelColors.blueBex10.withAlphaComponent(0.5)
            
            self.newLoader = UIImageView()
            self.newLoader?.translatesAutoresizingMaskIntoConstraints = false
            self.newLoader?.contentMode = .scaleAspectFit
            self.newLoader?.image = UIImage(named: "loader_icon")
            
            guard let nonNilBackgroundView = self.backgroundView, let nonNilLoader = self.newLoader else {
                return
            }
            
            guard let nonNilKeyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else {
                return
            }
            
            nonNilKeyWindow.addSubview(nonNilBackgroundView)
            nonNilKeyWindow.bringSubviewToFront(nonNilBackgroundView)
            
            nonNilBackgroundView.addSubview(nonNilLoader)
            
            NSLayoutConstraint.activate([
                nonNilLoader.centerYAnchor.constraint(equalTo: nonNilBackgroundView.centerYAnchor),
                nonNilLoader.centerXAnchor.constraint(equalTo: nonNilBackgroundView.centerXAnchor),
                nonNilLoader.widthAnchor.constraint(equalTo: nonNilBackgroundView.widthAnchor, multiplier: 0.3),
                nonNilLoader.heightAnchor.constraint(equalTo: nonNilLoader.heightAnchor),
            ])
            
            nonNilLoader.startRotateAnimation(direction: -1)
            
            self.isVisible = true
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            self.isVisible = false
            
            self.newLoader?.stopRotateAnimation()
            self.newLoader?.removeFromSuperview()
            self.newLoader = nil
            
            self.backgroundView?.removeFromSuperview()
            self.backgroundView = nil
        }
    }
}
