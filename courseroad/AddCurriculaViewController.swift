//
//  AddCurriculaViewController.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class AddCurriculaViewController: UIViewController {
    
    @IBOutlet weak var majorView: UIView!
    @IBOutlet weak var minorView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layour Constants
        let buttonWidth: CGFloat = 100
        let buttonHeight = 0.4 * buttonWidth
        let rowBuffer: CGFloat = 3 * CGFloat(M_PI)
        var lowerBuffer: CGFloat = 120
        let startingY: CGFloat = 69 + 130
        let x_maj = self.view.bounds.width * 0.3 - buttonWidth / 2
        let x_min = self.view.bounds.width * 0.7 - buttonWidth / 2
        let x_mid = self.view.bounds.width / 2 - buttonWidth / 2
        
        
        // Display Majors
        var counter = 0
        var row: CGFloat = 0
        //        for course in Globals.data {
        for course in Globals.majors {
            let buttonText = course.number!
            
            let buttonRect = CGRect(x: x_maj, y: row * (buttonHeight + rowBuffer) + startingY, width: buttonWidth, height: buttonHeight)
            
            let courseButton = CourseButton(frame: buttonRect, text: buttonText)
            
            counter += 1
            row += 1
            
            self.view.addSubview(courseButton)
        }
        // Add Major Button
        
        let addMajorButton = CourseButton(frame: CGRect(x: x_maj, y: self.view.bounds.maxY - lowerBuffer - buttonHeight, width: buttonWidth, height: buttonHeight), text: "+ major")
        
        addMajorButton.addTarget(self, action: #selector(addMajorPressed), for: .touchUpInside)
        
        // Disabled and Opaque button if already full of majors
        if Globals.majors.count >= 2 {
            addMajorButton.fillColor = addMajorButton.fillColor.withAlphaComponent(0.4)
            addMajorButton.isUserInteractionEnabled = false
        }
        self.view.addSubview(addMajorButton)
        
        
        // Minors
        counter = 0
        row = 0
        for course in Globals.minors {
            let buttonText = course.number!
            
            let buttonRect = CGRect(x: x_min, y: row * (buttonHeight + rowBuffer) + startingY, width: buttonWidth, height: buttonHeight)
            
            let courseButton = CourseButton(frame: buttonRect, text: buttonText)
            courseButton.fillColor = UIColor.flatYellowDark
            
            counter += 1
            row += 1
            
            self.view.addSubview(courseButton)
        }
        
        // Add Minor Button
        let addMinorButton = CourseButton(frame: CGRect(x: x_min, y: self.view.bounds.maxY - lowerBuffer - buttonHeight, width: buttonWidth, height: buttonHeight), text: "+ minor")
        addMinorButton.fillColor = UIColor.flatYellowDark
        
        addMinorButton.addTarget(self, action: #selector(addMinorPressed), for: .touchUpInside)
        
        // Disabled and Opaque button if already full of majors
        if Globals.minors.count >= 2 {
            addMinorButton.fillColor = addMinorButton.fillColor.withAlphaComponent(0.4)
            addMinorButton.isUserInteractionEnabled = false
        }
        self.view.addSubview(addMinorButton)
        
        
        
        // Continue Button
        lowerBuffer = 60
        let continueButton = CourseButton(frame: CGRect(x: x_mid, y: self.view.bounds.maxY - buttonHeight - lowerBuffer, width: buttonWidth, height: buttonHeight), text: "continue")
        
        continueButton.addTarget(self, action: #selector(continuePressed), for: .touchUpInside)
        continueButton.fillColor = UIColor.flatWatermelonDark
        self.view.addSubview(continueButton)
        
        
        // Reset Button
        lowerBuffer = 60
        let resetButton = CourseButton(frame: CGRect(x: x_maj, y: self.view.bounds.maxY - buttonHeight - lowerBuffer, width: buttonWidth, height: buttonHeight), text: "reset")
        
        resetButton.addTarget(self, action: #selector(resetPressed), for: .touchUpInside)
        resetButton.fillColor = UIColor.flatRedDark
        //        self.view.addSubview(resetButton)
    }
    
    
    func resetPressed(_ sender: CourseButton) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    func addMajorPressed(_ sender: CourseButton) {
        performSegue(withIdentifier: "CurriculumView", sender: sender)
    }
    
    func addMinorPressed(_ sender: CourseButton) {
        performSegue(withIdentifier: "CurriculumView", sender: sender)
    }
    
    func continuePressed(_ sender: CourseButton) {
        performSegue(withIdentifier: "MainPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! != "MainPage" {
            let sender = sender as! CourseButton
            let controller = segue.destination as! CurriculumViewController
            
            // Set data for next controller
            if sender.text == "+ major" {
                controller.curriculumType = "major"
            } else if sender.text == "+ minor" {
                controller.curriculumType = "minor"
            }
        }
    }
}
