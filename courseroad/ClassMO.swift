//
//  ClassMO.swift
//  coarseroad
//
//  Created by Juan Diego Fajardo on 2/2/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import CoreData

@objc(ClassMO)
open class ClassMO: NSManagedObject {
    @NSManaged var type: String
    @NSManaged var name: String?
    @NSManaged var year: NSNumber?
    @NSManaged var semester: String?
    @NSManaged var color: UIColor?
    
    open override var description: String {
        let descDict: [String: AnyObject?] = [
            "type" : type as AnyObject?,
            "name" : name as AnyObject?,
            "year" : year,
            "semester" : semester as AnyObject?,
            "color" : color!
        ]
        
        return String(describing: descDict)
    }
}
