//
//  ClassButton.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import ChameleonFramework

class ClassButton: UIButton {
    
    // Instance Vars (UI and Detail)
    @IBInspectable var fillColor: UIColor = UIColor.flatMint
    @IBInspectable var isAddButton: Bool = false
    @IBInspectable var isHassClass: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var hassType: String = ""
    @IBInspectable var isRestClass: Bool = false
    @IBInspectable var isCommunicationClass: Bool = false
    @IBInspectable var communicationType = ""
    @IBInspectable var isInstituteLab: Bool = false
    @IBInspectable var labType: String = ""
    @IBInspectable var text: String = ""
    var borderColor: UIColor = UIColor.flatBlack
    var textColor: UIColor = UIColor.white
    var showBorder: Bool = false {
        didSet {
            updateBorder()
        }
    }
    
    var MO: ClassMO? = nil
    
    var data: [String: AnyObject] = [:]
    
    override var description: String {
        let descDict: [String : AnyObject?] = [
            "title" : text as Optional<AnyObject>,
            "super" : superview
        ]
        
        return String(describing: descDict)
    }
    
    init(frame: CGRect, text: String, hassType: String?, commType: String?, labType: String?, isRest: Bool = false) {
        super.init(frame: frame)
        
        self.text = text
        
        if let hassType = hassType {
            self.isHassClass = true
            self.hassType = hassType
        }
        
        if let commType = commType {
            self.isCommunicationClass = true
            self.communicationType = commType
        }
        
        if let labType = labType {
            self.isInstituteLab = true
            self.labType = labType
        }
        
        self.isRestClass = isRest
        
        //
        
        
        self.layer.cornerRadius = bounds.height * 50 / 409
        self.layer.borderColor = self.borderColor.cgColor
        self.clearsContextBeforeDrawing = true
        
        
        // =======================
        //  BUTTON ICON ADDITION |
        // =======================
        
        // HASS CLASS
        let hassDiam = bounds.height * 152 / 409
        let hassBuffer = bounds.height * 25 / 409
        
        if isHassClass {
            let hassRect = CGRect(x: bounds.width - hassBuffer - hassDiam, y: hassBuffer, width: hassDiam, height: hassDiam)
            
            let hassImage = UIImageView(frame: hassRect)
            hassImage.image = hassImageFromSetting()
            self.addSubview(hassImage)
        }
        
        
        // COMMUNICATION CLASS
        let commDiam = bounds.height * 142 / 409
        let commBuffer = bounds.height * 30 / 409
        
        if isCommunicationClass {
            let commRect = CGRect(x: commBuffer, y: commBuffer, width: commDiam, height: commDiam)
            
            let commImage = UIImageView(frame: commRect)
            commImage.image = commImageFromSetting()
            self.addSubview(commImage)
        }
        
        
        // REST CLASS
        let restXBuffer = bounds.height * 18 / 409
        let restYBuffer = bounds.height * 22 / 409
        let restDiam = bounds.height * 183 / 409
        
        if isRestClass {
            let restRect = CGRect(x: bounds.width - restXBuffer - restDiam, y: bounds.height - restYBuffer - restDiam, width: restDiam, height: restDiam)
            
            let restImage = UIImageView(frame: restRect)
            restImage.image = Globals.Icons.restIcon
            self.addSubview(restImage)
        }
        
        
        // INSTITUTE LAB CLASSES
        let labXBuffer = bounds.height * 33 / 409
        let labYBuffer = bounds.height * 39 / 409
        let labHeight = bounds.height * 151 / 409
        var labWidth = bounds.height * 151 / 409
        
        if labType == "h" {
            labWidth = bounds.height * 151 / 2 / 409
        }
        
        if labType != "" {
            let labRect = CGRect(x: labXBuffer, y: bounds.height - labYBuffer - labHeight, width: labWidth, height: labHeight)
            
            let labImage = UIImageView(frame: labRect)
            labImage.image = labImageFromSetting()
            self.addSubview(labImage)
        }
        
        
        // ========================
        //   CLASS TEXT ADDITION  |
        // ========================
        
        let classBuffer = bounds.width * 0.037
        let classLabel = UILabel(frame: CGRect(x: commBuffer + commDiam + classBuffer, y: bounds.height * 0.15, width: bounds.width - commBuffer - commDiam - hassBuffer - hassDiam - 2*classBuffer, height: bounds.height * 0.7))
        
        // class label customizations
        classLabel.font = UIFont(name: Globals.Fonts.systemLight, size: bounds.height * 180 / 409)
        classLabel.adjustsFontSizeToFitWidth = true
        classLabel.text = text
        classLabel.textAlignment = .center
        classLabel.textColor = self.textColor
        //        classLabel.backgroundColor = UIColor.blueColor()
        self.addSubview(classLabel)
        
        
        // =====================
        //        EXTRAS       |
        // =====================
        
        self.isEnabled = true
        
        
        
    }
    
    convenience init(frame: CGRect, title: String) {
        self.init(frame: frame, text: title, hassType: "h", commType: nil, labType: nil, isRest: false)
    }
    
    convenience override init(frame: CGRect) {
        self.init(frame: frame, text: "21.S987", hassType: "h", commType: nil, labType: nil, isRest: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        // =======================
        //  BUTTON ICON ADDITION |
        // =======================
        
        // HASS CLASS
        let hassDiam = bounds.height * 152 / 409
        let hassBuffer = bounds.height * 25 / 409
        
        if isHassClass {
            let hassRect = CGRect(x: bounds.width - hassBuffer - hassDiam, y: hassBuffer, width: hassDiam, height: hassDiam)
            
            let hassImage = UIImageView(frame: hassRect)
            hassImage.image = hassImageFromSetting()
            self.addSubview(hassImage)
        }
        
        
        // COMMUNICATION CLASS
        let commDiam = bounds.height * 142 / 409
        let commBuffer = bounds.height * 30 / 409
        
        if isCommunicationClass {
            let commRect = CGRect(x: commBuffer, y: commBuffer, width: commDiam, height: commDiam)
            
            let commImage = UIImageView(frame: commRect)
            commImage.image = commImageFromSetting()
            self.addSubview(commImage)
        }
        
        
        // REST CLASS
        let restXBuffer = bounds.height * 18 / 409
        let restYBuffer = bounds.height * 22 / 409
        let restDiam = bounds.height * 183 / 409
        
        if isRestClass {
            let restRect = CGRect(x: bounds.width - restXBuffer - restDiam, y: bounds.height - restYBuffer - restDiam, width: restDiam, height: restDiam)
            
            let restImage = UIImageView(frame: restRect)
            restImage.image = Globals.Icons.restIcon
            self.addSubview(restImage)
        }
        
        
        // INSTITUTE LAB CLASSES
        let labXBuffer = bounds.height * 33 / 409
        let labYBuffer = bounds.height * 39 / 409
        let labHeight = bounds.height * 151 / 409
        var labWidth = bounds.height * 151 / 409
        
        if labType == "h" {
            labWidth = bounds.height * 151 / 2 / 409
        }
        
        if labType != "" {
            let labRect = CGRect(x: labXBuffer, y: bounds.height - labYBuffer - labHeight, width: labWidth, height: labHeight)
            
            let labImage = UIImageView(frame: labRect)
            labImage.image = labImageFromSetting()
            self.addSubview(labImage)
        }
        
        
        // ========================
        //   CLASS TEXT ADDITION  |
        // ========================
        
        let classBuffer = bounds.width * 0.037
        let classLabel = UILabel(frame: CGRect(x: commBuffer + commDiam + classBuffer, y: bounds.height * 0.15, width: bounds.width - commBuffer - commDiam - hassBuffer - hassDiam - 2*classBuffer, height: bounds.height * 0.7))
        
        // class label customizations
        classLabel.font = UIFont(name: Globals.Fonts.systemLight, size: bounds.height * 180 / 409)
        classLabel.adjustsFontSizeToFitWidth = true
        classLabel.text = text
        classLabel.textAlignment = .center
        classLabel.textColor = self.textColor
        //        classLabel.backgroundColor = UIColor.blueColor()
        self.addSubview(classLabel)
        
        
        // =====================
        //        EXTRAS       |
        // =====================
        
        self.isEnabled = true
        
        
    }
    
    
    // Func to draw button
    override func draw(_ rect: CGRect) {
        // Draw Button Shape
        let path = UIBezierPath(roundedRect: rect, cornerRadius: bounds.height * 50 / 409)
        fillColor.setFill()
        path.fill()
        
        //
        //
        //        // =======================
        //        //  BUTTON ICON ADDITION |
        //        // =======================
        //
        //        // HASS CLASS
        //        let hassDiam = bounds.height * 152 / 409
        //        let hassBuffer = bounds.height * 25 / 409
        //
        //        if isHassClass {
        //            let hassRect = CGRect(x: bounds.width - hassBuffer - hassDiam, y: hassBuffer, width: hassDiam, height: hassDiam)
        //
        //            let hassImage = UIImageView(frame: hassRect)
        //            hassImage.image = hassImageFromSetting()
        //            self.addSubview(hassImage)
        //        }
        //
        //
        //        // COMMUNICATION CLASS
        //        let commDiam = bounds.height * 142 / 409
        //        let commBuffer = bounds.height * 30 / 409
        //
        //        if isCommunicationClass {
        //            let commRect = CGRect(x: commBuffer, y: commBuffer, width: commDiam, height: commDiam)
        //
        //            let commImage = UIImageView(frame: commRect)
        //            commImage.image = commImageFromSetting()
        //            self.addSubview(commImage)
        //        }
        //
        //
        //        // REST CLASS
        //        let restXBuffer = bounds.height * 18 / 409
        //        let restYBuffer = bounds.height * 22 / 409
        //        let restDiam = bounds.height * 183 / 409
        //
        //        if isRestClass {
        //            let restRect = CGRect(x: bounds.width - restXBuffer - restDiam, y: bounds.height - restYBuffer - restDiam, width: restDiam, height: restDiam)
        //
        //            let restImage = UIImageView(frame: restRect)
        //            restImage.image = Globals.Icons.restIcon
        //            self.addSubview(restImage)
        //        }
        //
        //
        //        // INSTITUTE LAB CLASSES
        //        let labXBuffer = bounds.height * 33 / 409
        //        let labYBuffer = bounds.height * 39 / 409
        //        let labHeight = bounds.height * 151 / 409
        //        var labWidth = bounds.height * 151 / 409
        //
        //        if labType == "h" {
        //            labWidth = bounds.height * 151 / 2 / 409
        //        }
        //
        //        if labType != "" {
        //            let labRect = CGRect(x: labXBuffer, y: bounds.height - labYBuffer - labHeight, width: labWidth, height: labHeight)
        //
        //            let labImage = UIImageView(frame: labRect)
        //            labImage.image = labImageFromSetting()
        //            self.addSubview(labImage)
        //        }
        //
        //
        //        // ========================
        //        //   CLASS TEXT ADDITION  |
        //        // ========================
        //
        //        let classBuffer = bounds.width * 0.037
        //        let classLabel = UILabel(frame: CGRect(x: commBuffer + commDiam + classBuffer, y: bounds.height * 0.15, width: bounds.width - commBuffer - commDiam - hassBuffer - hassDiam - 2*classBuffer, height: bounds.height * 0.7))
        //
        //        // class label customizations
        //        classLabel.font = UIFont(name: Globals.Fonts.systemLight, size: bounds.height * 180 / 409)
        //        classLabel.adjustsFontSizeToFitWidth = true
        //        classLabel.text = text
        //        classLabel.textAlignment = .Center
        //        classLabel.textColor = UIColor.whiteColor()
        //        //        classLabel.backgroundColor = UIColor.blueColor()
        //        self.addSubview(classLabel)
        //
        //
        //        // =====================
        //        //        EXTRAS       |
        //        // =====================
        //
        //        self.enabled = true
        //
    }
    
    
    // Get proper HASS icon
    func hassImageFromSetting() -> UIImage? {
        switch hassType {
        case "h":
            return Globals.Icons.hassHumanitiesIcon
        case "a":
            return Globals.Icons.hassArtsIcon
        case "s":
            return Globals.Icons.hassSocialStudiesIcon
        case "e":
            return Globals.Icons.hassElectiveIcon
        default:
            return nil
        }
    }
    
    // Get proper CI icon
    func commImageFromSetting() -> UIImage? {
        switch communicationType {
        case "h":
            return Globals.Icons.commHumanitiesIcon
        case "w":
            return Globals.Icons.commWritingIcon
        case "m":
            return Globals.Icons.commMajorIcon
        default:
            return nil
        }
    }
    
    // Get proper LAB icon
    func labImageFromSetting() -> UIImage? {
        switch labType {
        case "f":
            return Globals.Icons.fullLabIcon
        case "h":
            return Globals.Icons.halfLabIcon
        default:
            return nil
        }
    }
    
    func updateBorder() {
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = showBorder ? 3 : 0
    }
    
}
