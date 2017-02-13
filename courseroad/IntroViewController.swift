//
//  IntroViewController.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Starting Sequence
        let width: CGFloat = 125
        let height = width * 0.409
        let meme = ClassButton(frame: CGRect(x: self.view.bounds.width / 2 - width / 2, y: self.view.bounds.height * 0.25, width: width, height: height))
        self.view.addSubview(meme)
        
        
        sleep(3)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(3)
        self.performSegue(withIdentifier: "SchemePicker", sender: self)
    }
}
