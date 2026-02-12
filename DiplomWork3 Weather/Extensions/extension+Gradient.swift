//
//  extension+Gradient.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 9.02.26.
//

import UIKit

extension UIView {
    func gradient(){
        layer.sublayers?.first { $0 is CAGradientLayer }?.removeFromSuperlayer()
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.init(red: 255/255, green: 119/255, blue: 250/255, alpha: 0).cgColor,
            UIColor.init(red: 255/255, green: 119/255, blue: 250/255, alpha: 0).cgColor,
            UIColor.init(red: 255/255, green: 119/255, blue: 250/255, alpha: 0).cgColor,
            UIColor.init(red: 255/255, green: 219/255, blue: 225/255, alpha: 1).cgColor,
            UIColor.init(red: 255/255, green: 219/255, blue: 225/255, alpha: 1).cgColor,
            UIColor.init(red: 255/255, green: 219/255, blue: 225/255, alpha: 1).cgColor,
            UIColor.white.cgColor,
            UIColor.white.cgColor
        ]
        gradient.frame = bounds
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.opacity = 0.8
        
        
        
        layer.insertSublayer(gradient, at: 0)
    }
    
   
}
