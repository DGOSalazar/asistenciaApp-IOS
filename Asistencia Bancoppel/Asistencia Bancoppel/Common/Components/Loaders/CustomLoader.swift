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
    private static var loader: UIActivityIndicatorView?

    
    static func show() {
        DispatchQueue.main.async {
            guard !isVisible else {
                return
            }
            
            self.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            self.backgroundView?.backgroundColor = .black.withAlphaComponent(0.4)
            
            self.loader = UIActivityIndicatorView()
            self.loader?.translatesAutoresizingMaskIntoConstraints = false
            
            guard let nonNilBackgroundView = self.backgroundView, let nonNilLoader = self.loader else {
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
            ])
            
            nonNilLoader.startAnimating()
            
            self.isVisible = true
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            self.isVisible = false
            
            self.loader?.stopAnimating()
            self.loader?.removeFromSuperview()
            self.loader = nil
            
            self.backgroundView?.removeFromSuperview()
            self.backgroundView = nil
        }
    }
}
