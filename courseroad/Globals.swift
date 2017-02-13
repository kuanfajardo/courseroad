//
//  Globals.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import CoreData

struct Globals {
    
    static var Defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    static var dataController: DataController {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.dataController
        
    }
    
    static var managedObjectContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.dataController.managedObjectContext
    }
    
    
    //--------------------------------------------------------------------------------------------------
    // Custom for Demo

    static var m = Major(number: "2A", name: "mech", department: "MECHE", isPrimaryMajor: false, completionYear: 2019)
    static var mi = Minor(number: "9", name: "brain and cognitive science", department: "BCS")
    static var mii = Minor(number: "energy", name: "energy", department: "MECHE")
    static var majors: [Major] = []//[m]
    static var minors: [Minor] = []//[mi, mii]
    
    static var data: [String : [[String : String]]] = [:]
    
    static var majorData: [(String, [String])] = [("1", ["1A", "1C", "1E", "1ENG"]), ("2", []), ("3", []), ("4", []), ("5", []), ("6", ["6-1 old", "6-1 new", "6-2 old", "6-2 new", "6-3 old", "6-3 new", "6-7 old", "6-7 new"]), ("7", []), ("8", []), ("9", []), ("10", []), ("11", []), ("12", []), ("14", []), ("15", []), ("16", []), ("17", []), ("18", []), ("20", []), ("21", []), ("22", []), ("24", []), ("CMS", []), ("STS", []), ("WGS", [])]
    
    static var course6CourseRoad: [[String:Any]] = [
        [
            "title" : "4 CS Header Subjects",
            "completed" : true,
            "children" : [
                [
                    "title" : "6.031",
                    "completed" : true,
                    "children" : []
                ],
                [
                    "title" : "6.033",
                    "completed" : false,
                    "children" : []
                ],
                [
                    "title" : "1 from:",
                    "completed" : false,
                    "children" : [
                        [
                            "title" : "6.045",
                            "completed" : false,
                            "children" : []
                        ],
                        [
                            "title" : "6.046",
                            "completed" : true,
                            "children" : []
                        ]
                    ]
                ]
            ]
        ],
        [
            "title" : "3 CS Foundation Subjects",
            "completed" : false,
            "children" : [
                [
                    "title" : "6.004",
                    "completed" : true,
                    "children" : []
                ],
                [
                    "title" : "6.006",
                    "completed" : false,
                    "children" : []
                ],
                [
                    "title" : "6.009",
                    "completed" : true,
                    "children" : []
                ]
            ]
        ]]
    
    //--------------------------------------------------------------------------------------------------
    
    struct Fonts {
        static let systemThin = "HelveticaNeue-Thin"
        static let systemThinBold = "HelveticaNeue-Bold"
        static let systemLight = "HelveticaNeue-Light"
    }
    
    struct Icons {
        static var hassHumanitiesIcon: UIImage  {
            return UIImage(named: "hass_h_icon")!
        }
        
        static var hassArtsIcon: UIImage  {
            return UIImage(named: "hass_a_icon")!
        }
        
        static var hassSocialStudiesIcon: UIImage  {
            return UIImage(named: "hass_s_icon")!
        }
        
        static var hassElectiveIcon: UIImage  {
            return UIImage(named: "hass_e_icon")!
        }
        
        static var restIcon: UIImage  {
            return UIImage(named: "rest_icon")!
        }
        
        static var fullLabIcon: UIImage  {
            return UIImage(named: "full_lab_icon")!
        }
        
        static var halfLabIcon: UIImage  {
            return UIImage(named: "half_lab_icon")!
        }
        
        static var commHumanitiesIcon: UIImage  {
            return UIImage(named: "ci_h_icon")!
        }
        
        static var commWritingIcon: UIImage  {
            return UIImage(named: "ci_hw_icon")!
        }
        
        static var commMajorIcon: UIImage  {
            return UIImage(named: "ci_m_icon")!
        }
        
        static var plusIcon: UIImage  {
            return UIImage(named: "add_icon")!
        }
        
        static var minusIcon: UIImage  {
            return UIImage(named: "minus_icon")!
        }
        
        static var settingsIcon: UIImage  {
            return UIImage(named: "settings_icon")!
        }
        
        static var moveIcon: UIImage  {
            return UIImage(named: "move_icon")!
        }
        
        static var oneIcon: UIImage  {
            return UIImage(named: "one_icon")!
        }
        
        static var twoIcon: UIImage  {
            return UIImage(named: "two_icon")!
        }
        
        static var threeIcon: UIImage  {
            return UIImage(named: "three_icon")!
        }
        
        static var fourIcon: UIImage  {
            return UIImage(named: "four_icon")!
        }
        
        static var cancelIcon: UIImage  {
            return UIImage(named: "cancel_icon")!
        }
        
        static var checkIcon: UIImage  {
            return UIImage(named: "check_icon")!
        }
        
        static var dropIcon: UIImage  {
            return UIImage(named: "drop_icon")!
        }
        
        static var infoIcon: UIImage  {
            return UIImage(named: "info_icon")!
        }
        
        static var backIcon: UIImage  {
            return UIImage(named: "back_icon")!
        }
        
        static var emptyCircleIcon: UIImage  {
            return UIImage(named: "empty_circle_icon")!
        }
        
        static var dropIconBlue: UIImage  {
            return UIImage(named: "drop_icon_blue")!
        }
        
        static var extraIcon: UIImage  {
            return UIImage(named: "extra_icon")!
        }
        
    }
}
