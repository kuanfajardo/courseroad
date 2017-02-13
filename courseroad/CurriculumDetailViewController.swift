//
//  CurriculumDetailViewController.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class CurriculumDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    var department: String = ""
    var dataIndex: Int = -1
    var curriculumType = "major"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Label Setup
        self.titleLabel.text = (self.curriculumType == "minor") ? "select your minor" : "select your course"
        
        // Layout Constants
        let buttonWidth: CGFloat = 100
        let buttonHeight = 0.4 * buttonWidth
        let tableBuffer: CGFloat = 30
        let rowBuffer: CGFloat = 3 * CGFloat(M_PI)
        let scrollViewWidth: CGFloat = self.view.bounds.width - 2 * tableBuffer
        let topBuffer: CGFloat = 69 + 28 + 20 + 29
        let cancelBuffer: CGFloat = 60
        var leftBuffer: CGFloat = 0
        let columnBuffer: CGFloat = 45
        var numColumns: CGFloat = 1
        
        
        // Layout Calculations
        var numRows: CGFloat =  CGFloat(Globals.majorData[dataIndex].1.count) / numColumns
        var scrollViewHeight = numRows * (buttonHeight + rowBuffer)
        
        // Columns Calculations
        if topBuffer + scrollViewHeight > self.view.bounds.maxY - buttonHeight - cancelBuffer {
            numColumns = 2
            numRows = CGFloat(Globals.majorData[dataIndex].1.count) / numColumns
            scrollViewHeight = numRows * (buttonHeight + rowBuffer)
            leftBuffer = scrollViewWidth / 2 - columnBuffer*3/2 - buttonWidth / 2
        }
        
        // Set ScrollView ContentSize
        self.scrollView.contentSize = CGSize(width: scrollViewWidth, height: scrollViewHeight)
        self.scrollView.isScrollEnabled = false
        
        // Create and Display Buttons
        var counter = 0
        var row: CGFloat = 0
        var column: CGFloat = 0
        //        for course in Globals.data {
        for course in Globals.majorData[dataIndex].1 {
            //            let buttonText = course.0
            let buttonText = course
            
            let x_mid = self.view.bounds.width / 2 - buttonWidth / 2 - tableBuffer
            var x: CGFloat
            
            // Calc x (middle for one column, offest for 2
            if numColumns == 1 {
                x = x_mid
            } else {
                x = column * (buttonWidth + columnBuffer) + leftBuffer
            }
            
            let buttonRect = CGRect(x: x, y: row * (buttonHeight + rowBuffer), width: buttonWidth, height: buttonHeight)
            
            let courseButton = CourseButton(frame: buttonRect, text: buttonText)
            courseButton.tag = counter
            courseButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
            
            // Color based on curriculum type
            if self.curriculumType == "minor" {
                courseButton.fillColor = UIColor.flatYellowDark
            }
            
            column += 1
            counter += 1
            if column == CGFloat(numColumns) {
                row += 1
                column = 0
            }
            
            self.scrollView.addSubview(courseButton)
        }
        
        // Cancel Button
        let x_mid = self.view.bounds.maxX / 2 - buttonWidth / 2 - 10 / 2
        
        let cancelButton = CourseButton(frame: CGRect(x: x_mid, y: self.view.bounds.maxY - buttonHeight - cancelBuffer, width: buttonWidth, height: buttonHeight), text: "cancel")
        
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        cancelButton.fillColor = UIColor.flatWatermelonDark
        self.view.addSubview(cancelButton)
    }
    
    
    func buttonPressed(_ sender: CourseButton) {
        // Add to corresponding curriculum global variable
        if self.curriculumType == "minor" {
            let minor = Minor(number: sender.text, name: "yeet", department: "YCD")
            Globals.minors.append(minor)
        } else {
            let isPrimaryMajor = Globals.majors.count == 0
            let major = Major(number: sender.text, name: "Computer Science + Engineering", department: "EECS", isPrimaryMajor: isPrimaryMajor, completionYear: 2019)
            Globals.majors.append(major)
        }
        
        self.performSegue(withIdentifier: "AddCurricula", sender: sender)
    }
    
    func cancelPressed(_ sender: UIButton) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
}
