//
//  CourseRoadPageViewController.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import CoreData

class CourseRoadPageViewController: UIPageViewController {
    
    var numPages = 5
    var titles = ["zero", "one", "two", "three", "four"]
    var frozen = false
    var index = 0
    
    var buttonInFocus: ClassButton? = nil
    var yearInFocus: Int? = nil
    
    var yearControllers: [YearViewController] = []
    
    var data = [NSManagedObject]()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        for i in 0..<self.numPages {
            let controller = storyboard?.instantiateViewController(withIdentifier: "YearViewController") as! YearViewController
            controller.year = i
            controller.titleText = titles[i]
            controller.delegate = self
            
            yearControllers.append(controller)
        }
        
        if let firstViewController = self.viewControllerAtIndex(1) {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if index < 0 || index >= self.numPages {
            return nil
        }
        
        return yearControllers[index]
    }
}


extension CourseRoadPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //
        //        guard self.frozen == false else {
        //            return nil
        //        }
        
        var index = (viewController as! YearViewController).year //- 1
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //
        //        guard self.frozen == false else {
        //            return nil
        //        }
        
        var index = (viewController as! YearViewController).year //- 1
        index += 1
        return viewControllerAtIndex(index)
    }
}

extension CourseRoadPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        let currentController = pageViewController.viewControllers![self.index] as! YearViewController
        if currentController.status == "edit" {
            currentController.status = "normal"
        }
        
        let nextViewController = pendingViewControllers.get(at: 0) as! YearViewController
        if currentController.status == "move" && nextViewController.status != "move"{
            nextViewController.status = "move"
        }
        
        if currentController.status == "normal" {
            if nextViewController.status == "move" {
                nextViewController.removeDropButtons()
            }
            nextViewController.status = "normal"
        }
    }
}


// Inter-Page Functions
extension CourseRoadPageViewController {
    func removeButtonInFocus() {
        print(yearInFocus! - 1)
        let controller = yearControllers[yearInFocus!]
        
        switch buttonInFocus!.superview! {
        case controller.fallView!:
            controller.fallBucket.removeFirst(buttonInFocus!)
            print("was in FALL")
        case controller.springView!:
            controller.springBucket.removeFirst(buttonInFocus!)
            print("was in SPRING")
        case controller.iapView!:
            controller.iapBucket.removeFirst(buttonInFocus!)
            print("was in IAP")
        default:
            print("BUG EXISTS HERE HEHEHEH")
            break
        }
        
        controller.allClassButtons.removeFirst(buttonInFocus!)
        buttonInFocus!.removeFromSuperview()
        
        for year in yearControllers {
            year.reloadData()
        }
    }
    
    func resetButtonInFocus() {
        for year in yearControllers {
            year.buttonInFocus = nil
        }
        self.buttonInFocus = nil
    }
    
    func saveAll() {
        for controller in yearControllers {
            controller.save()
        }
    }
}

