//
//  SchemeButton.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import ChameleonFramework

@IBDesignable
class SchemeButton: UIButton {
    
    // Colors
    @IBInspectable var colorOne: UIColor = UIColor.flatRed
    @IBInspectable var colorTwo: UIColor = UIColor.flatRedDark
    var showBorder: Bool = false {
        didSet {
            self.layer.borderWidth = showBorder ? 3 : 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Border Control
        layer.borderColor = UIColor.flatBlack.cgColor
        layer.cornerRadius = self.bounds.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Border Control
        layer.borderColor = UIColor.flatBlack.cgColor
        layer.cornerRadius = self.bounds.width / 2
    }
    
    override func draw(_ rect: CGRect) {
        // Draw Button
        let path = UIBezierPath(ovalIn: rect)
        colorOne.setFill()
        path.fill()
        
        // Draw Semicircle of color2
        let startPoint = CGPoint(x: bounds.width / 2, y: 0)
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height))
        path.addArc(withCenter: center, radius: bounds.width / 2, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(M_PI_2), clockwise: false)
        colorTwo.setFill()
        
        path.fill()
    }
}
