//
//  CourseButton.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class CourseButton: UIButton {
    var text: String = ""
    var fillColor = UIColor.flatMint
    var textColor = UIColor.white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = bounds.height * 50 / 409
        self.layer.borderColor = UIColor.flatBlack.cgColor
        self.clearsContextBeforeDrawing = true
    }
    
    convenience init(frame: CGRect, text: String) {
        self.init(frame: frame)
        self.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        // Button Shape
        let path = UIBezierPath(roundedRect: rect, cornerRadius: bounds.height / 10)
        fillColor.setFill()
        path.fill()
        
        
        // ========================
        //   CLASS TEXT ADDITION  |
        // ========================
        
        let classBuffer = bounds.width * 0.037
        let classLabel = UILabel(frame: CGRect(x: classBuffer, y: classBuffer, width: bounds.width - 2*classBuffer, height: bounds.height - 2*classBuffer))
        
        // class label customizations
        classLabel.font = UIFont(name: Globals.Fonts.systemLight, size: bounds.height * 180 / 409)
        classLabel.adjustsFontSizeToFitWidth = true
        classLabel.text = text
        classLabel.textAlignment = .center
        classLabel.textColor = textColor
        self.addSubview(classLabel)
    }
}
