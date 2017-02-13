//
//  SettingsViewController.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIGestureRecognizerDelegate {
    // Layout Constants
    var x_mid: CGFloat = 0
    let borderBuffer: CGFloat = 20
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        x_mid = self.view.bounds.width / 2
        
        // Back Button
        let buttonSize: CGFloat = 40
        let back_x = x_mid - buttonSize / 2
        let backYBuffer: CGFloat = 30
        
        let cancelRect = CGRect(x: back_x, y: self.view.bounds.height - borderBuffer - backYBuffer - buttonSize, width: buttonSize, height: buttonSize)
        let backImage = UIImageView(frame: cancelRect)
        backImage.image = Globals.Icons.backIcon
        
        let backTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(backPressed))
        backTapRecognizer.delegate = self
        backImage.addGestureRecognizer(backTapRecognizer)
        backImage.isUserInteractionEnabled = true
        self.view.addSubview(backImage)
    }
    
    func backPressed(_ sender: UITapGestureRecognizer) {
        print("back button pressed")
        self.dismiss(animated: true, completion: nil)
    }
    
}
