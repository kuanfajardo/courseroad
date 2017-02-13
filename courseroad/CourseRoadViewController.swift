//
//  CourseRoadViewController.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class CourseRoadViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var coursesView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Constants
        let x_mid = self.view.bounds.width / 2
        let borderBuffer: CGFloat = 20
        
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
        
        // Stack View and Buttons
        coursesView.w = view.w - 40
        let courses: [Curriculum] = (Globals.majors as [Curriculum]) + (Globals.minors as [Curriculum])
        
        print(coursesView.bounds.width, courses.count, buttonSize)
        let columnBuffer = (coursesView.w - (courses.count.toCGFloat * buttonSize)) / (courses.count.toCGFloat + 1)
        
        var column = 0.toCGFloat
        let numMajors = Globals.majors.count
        for course in courses {
            let courseRect = CGRect(x: columnBuffer + column * (columnBuffer + buttonSize), y: 0, w: buttonSize, h: buttonSize)
            
            let courseImageButton = CourseButton(frame: courseRect, text: course.number!)
            self.coursesView.addSubview(courseImageButton)
            
            if (Int(column) + 1) > numMajors {
                courseImageButton.fillColor = UIColor.flatYellowDark
            }
            column += 1
        }
        
        // CourseRoad View -- contained within scroll view
        let widthFactor: CGFloat = 0.12
        let scrollHeight = backImage.frame.minY - coursesView.frame.maxY - 2*borderBuffer
        let scrollView = UIScrollView(frame: CGRect(x: view.w * widthFactor, y: coursesView.frame.maxY + borderBuffer, w: view.w*(1 - 2*widthFactor), h: scrollHeight))
        
        let courseRoadView = createCellWithContent(Globals.course6CourseRoad, withinFrame: scrollView.bounds)
        
        // Fix Content Size to be Size of Content
        scrollView.contentSize = CGSize(width: view.w*(1 - 2*widthFactor), height: (getBufferFactorForCellIn(Globals.course6CourseRoad, withTargetTitle: "").0.toCGFloat - 1) * 38)
        
        scrollView.addSubview(courseRoadView)
        self.view.addSubview(scrollView)
    }
    
    func backPressed(_ sender: UITapGestureRecognizer) {
        print("back button pressed")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MAIN WORK - CREATE COURSEROAD VIEW
    func createCellWithContent(_ content: [[String:Any]], withinFrame guideFrame: CGRect, atLevel level: Int = 0) -> UIView {
        // Layout Constantes
        let edgeBuffer = 8.toCGFloat
        let iconSize = 30.toCGFloat
        let idealCellHeight = 38.toCGFloat
        
        // View Containers
        var cells: [UIView] = [] // to keep track of previous cells' positions
        let mainView = UIView(frame: guideFrame)
        
        // For Each Requirement, create cell in contentView; then add contentView to mainView
        let count = 0.toCGFloat
        for req in content {
            print(req["title"])
            // Calculate starting Y position
            let startingY: CGFloat
            
            if cells.isEmpty {
                startingY = 0
                print("isempty")
            } else {
                startingY = (cells.last?.frame.maxY)!
            }
            print("startingY: ", startingY)
            // Content View for this Requirement
            let contentRect = CGRect(x: mainView.bounds.minX, y: startingY, w: mainView.bounds.w, h: idealCellHeight)
            let contentView = UIView(frame: contentRect)
            
            
            // Check Image
            let imageRect = CGRect(x: contentView.bounds.minX + edgeBuffer, y: contentView.bounds.minY + edgeBuffer, w: iconSize, h: iconSize)
            
            let checkImage = UIImageView(frame: imageRect)
            checkImage.image = req["completed"] as! Bool ? Globals.Icons.checkIcon : Globals.Icons.emptyCircleIcon
            
            // Requirement Title Label
            let labelRect = CGRect(x: checkImage.bounds.maxX + edgeBuffer*2, y: checkImage.bounds.minY + 9.5, w: 100, h: iconSize)
            
            let label = UILabel(frame: labelRect)
            label.font = UIFont(name: Globals.Fonts.systemThin, size: 20)
            label.textColor = UIColor.flatWhite
            label.text = req["title"] as? String
            label.fitSize()
            
            // Add to Content View
            contentView.addSubview(checkImage)
            contentView.addSubview(label)
            
            
            // If have Children, create their content views recursively
            let childContent = req["children"] as? [[String:AnyObject]]
            
            if childContent?.isEmpty == false {
                let childFrame = CGRect(x: checkImage.frame.maxX, y: checkImage.frame.maxY, w: contentView.w, h: contentView.h)
                
                let childView = createCellWithContent(childContent!, withinFrame: childFrame, atLevel: level + 1)
                
                contentView.addSubview(childView)
            }
            
            // Add Content View to cell containers
            cells.append(contentView)
            mainView.addSubview(contentView)
            
            // Fix height of main cells
            if level == 0 {
                let bufferFactor = getBufferFactorForCellIn(content, withTargetTitle: content[Int(count + 1)]["title"] as! String).0.toCGFloat
                
                contentView.size = CGSize(width: contentView.w, height: idealCellHeight * (bufferFactor - 1))
            }
        }
        
        return mainView
    }
    
    func getBufferFactorForCellIn(_ content: [[String:Any]], withTargetTitle title: String) -> (Int, Bool) {
        var count = 1
        var index = 0
        var current = content[index]
        while current["title"] as! String != title {
            print(current["title"])
            print(count)
            let child = current["children"] as! [[String:Any]]
            
            if child.count == 0 {
                count += 1
            } else {
                let result = getBufferFactorForCellIn(child, withTargetTitle: title)
                let newCount = result.0
                let success = result.1
                
                count += newCount
                if success {
                    return (count, true)
                }
            }
            
            if index < content.count - 1 {
                current = content[index + 1]
                index += 1
            } else {
                return (count, false)
            }
        }
        
        return (count, true)
    }
}
