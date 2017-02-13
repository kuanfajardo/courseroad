//
//  CurriculumViewController.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class CurriculumViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    var curriculumType = "primaryMajor"
    
    var cancelButton: UIImageView? = nil
    let cornerBuffer: CGFloat = 30
    var buttonSize: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Label Setup
        self.titleLabel.text = (self.curriculumType == "primaryMajor") ? "select your primary department" : (self.curriculumType == "major" ? "select your 2nd dept." : "select your minor")
        
        // Layout Constants
        let buttonWidth: CGFloat = 100
        let buttonHeight = 0.4 * buttonWidth
        let tableBuffer: CGFloat = 30
        let minColumnBuffer: CGFloat = 10
        let rowBuffer: CGFloat = 3 * CGFloat(M_PI)
        let scrollViewWidth: CGFloat = self.view.bounds.width - 2 * tableBuffer
        var numPerRow: CGFloat = 3
        var leftBuffer: CGFloat = 0
        
        // Layout Calculations
        var columnBuffer = (scrollViewWidth - (numPerRow * buttonWidth)) / (numPerRow - 1)
        
        if columnBuffer < minColumnBuffer {
            numPerRow -= 1
            columnBuffer = 45
            leftBuffer = scrollViewWidth / 2 - columnBuffer*3/2 - buttonWidth / 2
        }
        
        //        let numRows: CGFloat = CGFloat(Globals.data.count) / numPerRow
        let numRows: CGFloat = CGFloat(Globals.majorData.count) / numPerRow
        let scrollViewHeight = numRows * (buttonHeight + rowBuffer)
        
        // Set ScrollView ContentSize
        self.scrollView.contentSize = CGSize(width: scrollViewWidth, height: scrollViewHeight)
        
        // Create and Display Buttons
        var counter = 0
        var column: CGFloat = 0
        var row: CGFloat = 0
        //        for course in Globals.data {
        for course in Globals.majorData {
            let buttonText = course.0
            
            let buttonRect = CGRect(x: column * (buttonWidth + columnBuffer) + leftBuffer, y: row * (buttonHeight + rowBuffer), width: buttonWidth, height: buttonHeight)
            
            let courseButton = CourseButton(frame: buttonRect, text: buttonText)
            courseButton.tag = counter
            courseButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
            // Color based on type of curricula
            if self.curriculumType == "minor" {
                courseButton.fillColor = UIColor.flatYellowDark
            }
            
            column += 1
            if column == CGFloat(numPerRow) {
                row += 1
                column = 0
            }
            
            counter += 1
            self.scrollView.addSubview(courseButton)
        }
        
        
        let topRightRect = CGRect(x: self.view.bounds.width - cornerBuffer - 40, y: cornerBuffer + 10, width: buttonSize, height: buttonSize)
        self.cancelButton = UIImageView(frame: topRightRect)
        cancelButton!.image = Globals.Icons.cancelIcon
        
        let topRightTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancelButtonPressed))
        topRightTapRecognizer.delegate = self
        cancelButton!.addGestureRecognizer(topRightTapRecognizer)
        cancelButton!.isUserInteractionEnabled = true
        
        //        self.view.addSubview(self.cancelButton!)
    }
    
    
    func buttonPressed(_ sender: CourseButton) {
        self.performSegue(withIdentifier: "CurriculumDetail", sender: sender)
    }
    
    func cancelButtonPressed(_ sender: UITapGestureRecognizer) {
        print("cancel pressed")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! CurriculumDetailViewController
        let sender = sender as! CourseButton
        
        // Set Data for next controller
        controller.dataIndex = sender.tag
        controller.department = sender.text
        controller.curriculumType = self.curriculumType
    }
    
}
