//
//  Curriculum.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class Curriculum {
    var department: String = ""
    var name: String = ""
    var number: String? = nil
    
    init(number: String, name: String, department: String) {
        self.department = department
        self.number = number
        self.name = name
    }
}

class Major: Curriculum {
    var isPrimaryMajor: Bool = true
    var completionYear: Int = 2020
    
    init(number: String, name: String, department: String, isPrimaryMajor: Bool, completionYear: Int) {
        super.init(number: number, name: name, department: department)
        self.isPrimaryMajor = isPrimaryMajor
        self.completionYear = completionYear
    }
    
    //    convenience init(number: String, name: String, department: String) {
    //        self.init(
    //    }
}

class Minor: Curriculum {
    override init(number: String, name: String, department: String) {
        let newNumber = number.length > 2 ? number.substring(with: Range<String.Index>(number.startIndex..<number.characters.index(number.startIndex, offsetBy: 2))) : number
        super.init(number: newNumber, name: name, department: department)
    }
}

extension Curriculum: Equatable {
}

func ==(lhs: Curriculum, rhs: Curriculum) -> Bool {
    return (lhs.number! == rhs.number!)
}

