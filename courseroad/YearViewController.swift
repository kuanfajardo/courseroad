//
//  YearViewController.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import JSSAlertView
import CoreData

class YearViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate: CourseRoadPageViewController? = nil
    
    var allClassButtons: [ClassButton] = []
    
    var topRightButton: UIImageView? = nil
    var topLeftButton: UIImageView? = nil
    var middleLeftButton: UIImageView? = nil
    var middleButton: UIImageView? = nil
    
    var year: Int = 0
    var titleText: String = ""
    
    var status: String = "normal" {
        didSet {
            if status == "edit" {
                self.topRightButton!.image = Globals.Icons.minusIcon
                self.topLeftButton!.image = Globals.Icons.moveIcon
                self.middleLeftButton!.isHidden = false
            } else if status == "normal" {
                self.topRightButton!.image = Globals.Icons.plusIcon
                self.topLeftButton!.image = Globals.Icons.settingsIcon
                self.middleLeftButton!.isHidden = true
                
                self.topLeftButton!.isHidden = false
                
                normalizeUI()
            } else if status == "move" {
                self.topRightButton!.image = Globals.Icons.cancelIcon
                self.topLeftButton!.image = Globals.Icons.dropIcon
                self.middleLeftButton!.isHidden = true
                self.topLeftButton!.isHidden = true
                
                placeButton(withData: ["type" : "drop" as AnyObject], inSemester: "fall")
                placeButton(withData: ["type" : "drop" as AnyObject], inSemester: "spring")
                placeButton(withData: ["type" : "drop" as AnyObject], inSemester: "iap")
                
                for button in allClassButtons {
                    button.isUserInteractionEnabled = false
                }
            }
        }
    }
    
    var buttonInFocus: ClassButton? = nil {
        didSet {
            delegate!.buttonInFocus = self.buttonInFocus
            delegate!.yearInFocus = self.buttonInFocus != nil ? self.year : nil
        }
    }
    
    var fallView: UIView? = nil
    var springView: UIView? = nil
    var iapView: UIView? = nil
    
    var fallBucket: [UIButton] = []
    var springBucket: [UIButton] = []
    var iapBucket: [UIButton] = []
    
    // Layout Constants Inits
    var borderBuffer: CGFloat = 20
    var semesterWidth: CGFloat = 0.0
    var buttonWidth: CGFloat = 0
    var buttonHeight: CGFloat = 0
    var iapHeight: CGFloat = 0
    var iapY: CGFloat = 0
    var semesterY: CGFloat = 0
    var semesterHeight: CGFloat = 0
    
    var numButtons: CGFloat = 5
    var button_x: CGFloat = 0
    var buttonBuffer: CGFloat = 30
    var buttonYBuffer: CGFloat = 0
    var minYBuffer: CGFloat = 30
    
    var iapButtonBuffer: CGFloat = 0
    var buttonXBuffer: CGFloat = 0
    
    let cornerBuffer: CGFloat = 30
    var buttonSize: CGFloat = 40
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Title Label - UI DECISION!!
        self.titleLabel.text = self.titleText
        self.titleLabel.isHidden = true // false to use text
        
        
        //--------------------------------
        //      LAYOUT CONSTANT CALC     |
        //--------------------------------
        
        semesterWidth = (self.view.bounds.width  - 2*borderBuffer) / 2
        buttonWidth = semesterWidth * 0.75
        buttonHeight = buttonWidth * 0.4
        iapHeight = buttonHeight * 1.65
        iapY = self.view.bounds.height - borderBuffer - iapHeight
        semesterY = 50 + self.titleLabel.bounds.height + borderBuffer
        semesterHeight = (self.view.bounds.height - borderBuffer - iapHeight) - semesterY
        button_x = (semesterWidth - buttonWidth) / 2
        buttonYBuffer = ((semesterHeight - 2*buttonBuffer) - (buttonHeight * numButtons)) / (numButtons - 1)
        buttonYBuffer = buttonYBuffer >= minYBuffer ? buttonYBuffer : minYBuffer
        iapButtonBuffer = (iapHeight - buttonHeight) / 2
        buttonXBuffer = semesterWidth*2 - (2 * button_x) - (2 * buttonWidth)
        
        
        //--------------------------
        //      SEMESTER VIEWS     |
        //--------------------------
        
        // Instantiate 3 main views
        fallView = UIView(frame: CGRect(x: borderBuffer, y: semesterY, width: semesterWidth, height: semesterHeight))
        
        fallView?.isUserInteractionEnabled = true
        
        springView = UIView(frame: CGRect(x: borderBuffer + semesterWidth, y: semesterY, width: semesterWidth, height: semesterHeight))
        
        iapView = UIView(frame: CGRect(x: borderBuffer, y: iapY, width: semesterWidth * 2, height: iapHeight))
        
        fallView!.backgroundColor = UIColor.flatSand
        springView!.backgroundColor = UIColor.flatPowderBlue
        iapView!.backgroundColor = UIColor.flatMintDark
        
        self.view.addSubview(fallView!)
        self.view.addSubview(springView!)
        self.view.addSubview(iapView!)
        
        
        //--------------------------
        //      CLASS LOADING      |
        //--------------------------
        
        let demoData: [String : [[String : Any]]] = [
            "fall_1" :
                [
                    [
                        "name" : "18.01A" as AnyObject,
                        "type" : "class" as AnyObject
                    ],
                    [
                        "name" : "8.01" as AnyObject,
                        "type" : "class" as AnyObject
                    ],
                    [
                        "name" : "7.016" as AnyObject,
                        "type" : "class" as AnyObject
                    ],
                    [
                        "name" : "24.02" as AnyObject,
                        "type" : "class" as AnyObject
                    ]
            ],
            "iap_1" :
                [
                    [
                        "name" : "18.02A" as AnyObject,
                        "type" : "class"
                    ],
                    [
                        "name" : "16.682",
                        "type" : "class"
                    ]
            ],
            "spring_1" :
                [
                    [
                        "name" : "6.01",
                        "type" : "class"
                    ],
                    [
                        "name" : "8.02",
                        "type" : "class"
                    ],
                    [
                        "name" : "6.042",
                        "type" : "class"
                    ],
                    [
                        "name" : "21M.600",
                        "type" : "class"
                    ],
                    [
                        "name" : "18.06",
                        "type" : "class"
                    ]
            ],
            "fall_2" :
                [
                    [
                        "name" : "9.01",
                        "type" : "class"
                    ],
                    [
                        "name" : "6.004",
                        "type" : "class"
                    ],
                    [
                        "name" : "6.006",
                        "type" : "class"
                    ],
                    [
                        "name" : "6.009",
                        "type" : "class"
                    ],
                    [
                        "name" : "6.01LA",
                        "type" : "custom",
                        "color" : UIColor.flatSkyBlue
                    ]
            ],
            "iap_2" :
                [
                    [
                        "name" : "GTL Italy",
                        "type" : "custom",
                        "color" : UIColor.flatPurple
                    ]
            ],
            "spring_2" : [],
            "fall_3" : [],
            "iap_3" : [],
            "spring_3" : [],
            "fall_4" : [],
            "iap_4" : [],
            "spring_4" : []
        ]
        
        
        let fallData = demoData["fall_\(year)"]
        let iapData = demoData["iap_\(year)"]
        let springData = demoData["spring_\(year)"]
        
        if year == 23 {
            for element in fallData! {
                placeButton(withData: element as [String : AnyObject], inSemester: "fall")
            }
            
            for element in springData! {
                placeButton(withData: element as [String : AnyObject], inSemester: "spring")
            }
            
            for element in iapData! {
                placeButton(withData: element as [String : AnyObject], inSemester: "iap")
            }
        }
        create()
        //        deleteAll()
        
        
        //------------------------
        //      MENU BUTTONS     |
        //------------------------
        
        // Top Right (Add) Button and TGR
        
        let topRightRect = CGRect(x: self.view.bounds.width - cornerBuffer - 40, y: cornerBuffer + 10, width: buttonSize, height: buttonSize)
        self.topRightButton = UIImageView(frame: topRightRect)
        topRightButton!.image = Globals.Icons.plusIcon
        
        let topRightTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(topRightButtonPressed))
        topRightTapRecognizer.delegate = self
        topRightButton!.addGestureRecognizer(topRightTapRecognizer)
        topRightButton!.isUserInteractionEnabled = true
        
        self.view.addSubview(self.topRightButton!)
        
        
        // Top Left (Settings) Button and TGR
        let topLeftRect = CGRect(x: cornerBuffer, y: cornerBuffer + 10, width: buttonSize, height: buttonSize)
        self.topLeftButton = UIImageView(frame: topLeftRect)
        topLeftButton!.image = Globals.Icons.settingsIcon
        
        let topLeftTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(topLeftButtonPressed))
        topLeftTapRecognizer.delegate = self
        topLeftButton!.addGestureRecognizer(topLeftTapRecognizer)
        topLeftButton!.isUserInteractionEnabled = true
        
        self.view.addSubview(self.topLeftButton!)
        
        
        // Set Page Number Icon
        let numberRect = CGRect(x: self.view.bounds.width / 2 - buttonSize / 2, y: cornerBuffer + 10, width: buttonSize, height: buttonSize)
        middleButton = UIImageView(frame: numberRect)
        middleButton!.image = getNumberIconFromSetting()
        
        let middleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(middleButtonPressed))
        middleTapRecognizer.delegate = self
        middleButton!.addGestureRecognizer(middleTapRecognizer)
        middleButton!.isUserInteractionEnabled = true
        
        self.view.addSubview(middleButton!)
        
        // Middle Left (Info) Icon
        let middleLeftRect = CGRect(x: (topLeftButton!.frame.maxX + middleButton!.frame.minX) / 2 - buttonSize / 2, y: cornerBuffer + 10, w: buttonSize, h: buttonSize)
        self.middleLeftButton = UIImageView(frame: middleLeftRect)
        middleLeftButton!.image = Globals.Icons.infoIcon
        
        let middleLeftTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(middleLeftButtonPressed))
        middleLeftButton?.addGestureRecognizer(middleLeftTapRecognizer)
        middleLeftButton!.isUserInteractionEnabled = true
        middleLeftButton!.isHidden = true
        
        self.view.addSubview(middleLeftButton!)
    }
    
    
    //-------------------------------
    //      MENU BUTTON ACTIONS     |
    //-------------------------------
    
    func topRightButtonPressed(_ sender: UITapGestureRecognizer) {
        if status == "normal" {
            print("add button pressed")
            self.performSegue(withIdentifier: "AddClassToBoard", sender: self)
        } else if status == "edit" {
            deleteSelectedClass()
            print("delete button pressed")
        } else if status == "move" {
            removeDropButtons()
            status = "normal"
        }
        
    }
    
    func topLeftButtonPressed(_ sender: UITapGestureRecognizer) {
        if status == "normal" {
            print("settings button pressed")
            performSegue(withIdentifier: "ShowSettings", sender: self)
            
        } else if status == "edit" {
            print("move button pressed")
            self.status = "move"
        }
    }
    
    func middleLeftButtonPressed(_ sender: UITapGestureRecognizer) {
        print("info button pressed")
        
        for button in allClassButtons {
            print(button)
        }
        print("-------")
        for b in fallBucket {
            print(b)
        }
        save()
        
        status = "normal"
    }
    
    func middleButtonPressed(_ sender: UITapGestureRecognizer) {
        print("middle button pressed")
        self.performSegue(withIdentifier: "CourseRoad", sender: self)
    }
    
    
    
    //----------------------
    //      UI HELPERS     |
    //----------------------
    
    func classButtonPressed(_ sender: ClassButton) {
        if buttonInFocus == nil {
            sender.showBorder = true
            self.status = "edit"
            buttonInFocus = sender
        } else {
            if buttonInFocus == sender {
                sender.showBorder = false
                self.status = "normal"
                buttonInFocus = nil
            } else {
                buttonInFocus!.showBorder = false
                buttonInFocus = sender
                sender.showBorder = true
            }
        }
        
        for button in allClassButtons {
            if button != sender {
                button.fillColor = button.fillColor.withAlphaComponent(sender.showBorder ? 0.5 : 1.0)
            } else {
                button.fillColor = button.fillColor.withAlphaComponent(1.0)
            }
            
            button.setNeedsDisplay()
        }
    }
    
    func normalizeUI() {
        buttonInFocus = nil
        for button in allClassButtons {
            button.fillColor = button.fillColor.withAlphaComponent(1.0)
            button.isUserInteractionEnabled = true
            button.showBorder = false
            button.setNeedsDisplay()
        }
    }
    
    func getNumberIconFromSetting() -> UIImage? {
        switch self.year {
        case 0:
            return Globals.Icons.extraIcon
        case 1:
            return Globals.Icons.oneIcon
        case 2:
            return Globals.Icons.twoIcon
        case 3:
            return Globals.Icons.threeIcon
        case 4:
            return Globals.Icons.fourIcon
        default:
            return nil
        }
    }
    
    func getPlaceholderButton(_ frame: CGRect) -> CourseButton {
        let placeholder = CourseButton(frame: frame, text: "")
        placeholder.fillColor = UIColor.flatWhite.withAlphaComponent(0.5)
        
        let arrowRect = CGRect(x: buttonWidth / 2 - buttonSize / 2, y: buttonHeight / 2 - buttonSize / 2, w: buttonSize, h: buttonSize)
        
        let yeet = UIImageView(frame: arrowRect)
        yeet.image = Globals.Icons.dropIconBlue
        placeholder.addSubview(yeet)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(placeholderButtonPressed))
        tapRecognizer.delegate = self
        placeholder.addGestureRecognizer(tapRecognizer)
        placeholder.isUserInteractionEnabled = true
        
        return placeholder
    }
    
    func placeholderButtonPressed(_ sender: UITapGestureRecognizer) {
        print("DROP TOPPPPP")
        print(sender.view!.superview! == fallView!)
        print(sender.view!.superview! == springView!)
        print(sender.view!.superview! == iapView!)
        
        
        if let buttonInFocus = buttonInFocus {
            print("in own year")
            removeButton(buttonInFocus)
        } else {
            print("other year")
            delegate!.removeButtonInFocus()
        }
        
        
        let oldView = sender.view!.superview!
        removeDropButtons()
        
        var semester: String = ""
        switch oldView {
        case fallView!:
            semester = "fall"
        case springView!:
            semester = "spring"
        case iapView!:
            semester = "iap"
        default:
            print("yetiyetiii")
            break
        }
        
        placeButton(withData: delegate!.buttonInFocus!.data, inSemester: semester)
        
        delegate!.resetButtonInFocus()
        delegate!.saveAll()
        status = "normal"
    }
    
    
    //---------------------------------
    //      FUNCTIONALITY HELPERS     |
    //---------------------------------
    
    func deleteSelectedClass() {
        let alertView = JSSAlertView().danger(
            self,
            title: "oh, crap",
            text: "Are you sure you want to delete this class?",
            buttonText: "Yes",
            cancelButtonText: "Cancel"
        )
        
        alertView.addAction {
            self.delegate!.removeButtonInFocus()
            self.save()
            self.status = "normal"
        }
        
        alertView.addCancelAction {
            self.status = "normal"
        }
    }
    
    
    func placeButton(withData data: [String : AnyObject], inSemester semester: String) {
        let type = data["type"] as! String
        
        let location = semester == "fall" ? fallBucket.count.toCGFloat : (semester == "spring" ? springBucket.count.toCGFloat : iapBucket.count.toCGFloat)
        
        let x = semester == "fall" || semester == "spring" ? button_x : button_x + (location * (buttonWidth + buttonXBuffer))
        
        let y = semester == "iap" ? iapButtonBuffer : buttonBuffer + (location * (buttonHeight + buttonYBuffer))
        
        let frame = CGRect(x: x, y: y, w: buttonWidth, h: buttonHeight)
        
        if type == "drop" {
            let button = getPlaceholderButton(frame)
            
            switch semester {
            case "fall":
                fallView!.addSubview(button)
                fallBucket.append(button)
            case "spring":
                springView!.addSubview(button)
                springBucket.append(button)
            case "iap":
                iapView!.addSubview(button)
                iapBucket.append(button)
            default:
                break
            }
            
        } else {
            let title = data["name"] as! String
            
            let button = ClassButton(frame: frame, title: title)
            button.data = data
            
            button.fillColor = type == "class" ? button.fillColor : (type == "error" ? UIColor.flatWatermelon : (type == "custom" ? data["color"] as! UIColor : UIColor.flatSkyBlue))
            
            
            button.addTarget(self, action: #selector(classButtonPressed), for: .touchUpInside)
            
            
            switch semester {
            case "fall":
                fallView!.addSubview(button)
                fallBucket.append(button)
            case "spring":
                springView!.addSubview(button)
                springBucket.append(button)
            case "iap":
                iapView!.addSubview(button)
                iapBucket.append(button)
            default:
                break
            }
            
            self.allClassButtons.append(button)
            print(button.superview)
            //            button.tag = 1
        }
    }
    
    func removeDropButtons() {
        fallBucket.removeLast().removeFromSuperview()
        springBucket.removeLast().removeFromSuperview()
        iapBucket.removeLast().removeFromSuperview()
    }
    
    func removeButton(_ button: ClassButton) {
        switch button.superview! {
        case fallView!:
            fallBucket.removeFirst(button)
        case springView!:
            springBucket.removeFirst(button)
        case iapView!:
            iapBucket.removeFirst(button)
        default:
            break
        }
        
        allClassButtons.removeFirst(button)
        button.removeFromSuperview()
        
        reloadData()
    }
    
    func reloadData() {
        print("reloading data")
        
        var counter = 0.toCGFloat
        for button in fallBucket {
            button.frame = CGRect(x: button.frame.x, y: getYForButtonAtPosition(counter), w: button.w, h: button.h)
            
            counter += 1
        }
        
        counter = 0
        for button in springBucket {
            button.frame = CGRect(x: button.frame.x, y: getYForButtonAtPosition(counter), w: button.w, h: button.h)
            
            counter += 1
        }
        
        counter = 0
        for button in iapBucket {
            button.frame = CGRect(x: getXForButtonAtPosition(counter), y: button.frame.y, w: button.w, h: button.h)
            
            counter += 1
        }
        
    }
    
    // NOTE: Only for Fall and Spring
    func getYForButtonAtPosition(_ position: CGFloat) -> CGFloat {
        return buttonBuffer + (position * (buttonHeight + buttonYBuffer))
    }
    
    func getXForButtonAtPosition(_ position: CGFloat) -> CGFloat {
        return button_x + (position * (buttonWidth + buttonXBuffer))
    }
    
    
    
    func save() {
        deleteAll()
        //        for object in Globals.managedObjectContext.
        for button in allClassButtons {
            let subject = NSEntityDescription.insertNewObject(forEntityName: "Subject", into: Globals.managedObjectContext) as! ClassMO
            
            
            print("saving ... \n", button.text)
            subject.color = button.fillColor
            subject.name = button.text
            subject.year = year as NSNumber?
            print(button.tag)
            print(button.superview!)
            subject.semester =  button.superview! == fallView! ? "fall" : (button.superview! == springView! ? "spring" : "iap")
            subject.type = button.data["type"] as! String
            print("saving ... \n", subject)
        }
        
        let success = Globals.dataController.saveContext()
        print("SUCCESS???: ", success)
    }
    
    func load() -> [ClassMO] {
        let moc = Globals.managedObjectContext
        print("eeeeeeeee")
        let subjectsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Subject")
        print("ooooooooo")
        subjectsFetch.predicate = NSPredicate(format: "year == %@", NSNumber(value: year as Int))
        print("uuuuuuuuuu")
        do {
            let fetchedSubjects = try moc.fetch(subjectsFetch) as! [ClassMO]
            
            return fetchedSubjects
        } catch {
            fatalError("Failed to fetch subjects: \(error)")
        }
        
        return []
    }
    
    func create() {
        let subjects = load()
        
        for subject in subjects {
            placeButton(withData: subject)
        }
        
    }
    
    func placeButton(withData data: ClassMO) {
        let subjectData: [String: AnyObject] = [
            "type" : data.type as AnyObject,
            "color" : data.color!,
            "name" : data.name! as AnyObject
        ]
        
        placeButton(withData: subjectData, inSemester: data.semester!)
    }
    
    func deleteAll() {
        let subjects = load()
        
        for subject in subjects {
            Globals.managedObjectContext.delete(subject)
        }
        
        Globals.dataController.saveContext()
    }
}

extension YearViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        //        print("yeet")removebuttonin
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        //        print("cyfvgbhknjlmk")
        return true
    }
}
