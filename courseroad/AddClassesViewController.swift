//
//  AddClassesViewController.swift
//  courseroad
//
//  Created by Juan Diego Fajardo on 2/12/17.
//  Copyright © 2017 Juan Diego Fajardo. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class AddClassesViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    var classButton: ClassButton? = nil
    var customButton: ClassButton? = nil
    var placeholderButton: ClassButton? = nil
    var multiButton: ClassButton? = nil
    var placeholderLabel: UILabel? = nil
    
    var buttons: [ClassButton] = []
    
    var selectLabel: UILabel? = nil
    var inputTextField: UITextField? = nil
    var continueImage: UIImageView? = nil
    var infoLabel: UILabel? = nil
    var numUnitsTextField: UITextField? = nil
    
    var selectedColor: UIColor = UIColor.flatPurple {
        didSet {
            self.customButton!.fillColor = selectedColor
            customButton!.setNeedsDisplay()
        }
    }
    
    var isSmallPhone: Bool {
        return view.bounds.height < 600
    }
    
    // Class UI
    var classUIBucket: [UIView?] = []
    var searchController: UISearchController? = nil
    var searchBar: UISearchBar? = nil
    var searchBarRect: CGRect? = nil
    var collectionView: UICollectionView? = nil
    
    // Custom UI
    var colorChoices: [UIColor] = [UIColor.flatPurple, UIColor.flatSkyBlue, UIColor.flatYellowDark, UIColor.flatPinkDark, UIColor.flatCoffee]
    var colorButtons: [SchemeButton] = []
    var customUIBucket: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Constants and Constraints
        let x_mid = self.view.bounds.width / 2
        let borderBuffer: CGFloat = 20
        let titleBuffer: CGFloat = 35
        var startingY = borderBuffer + 2*titleBuffer + self.titleLabel.bounds.height
        let buttonWidth: CGFloat = (self.view.bounds.width - 2*borderBuffer) * 0.4
        let buttonHeight = 0.4 * buttonWidth
        let labelBuffer: CGFloat = 0
        let labelXBufferFactor: CGFloat = 0.1
        let selectLabelWidth: CGFloat = 300
        let customRowBuffer: CGFloat = 20
        
        
        // new class button
        let classButtonRect = CGRect(x: self.view.bounds.width * 0.1, y: startingY, width: buttonWidth, height: buttonHeight)
        classButton = ClassButton(frame: classButtonRect)
        classButton!.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        //        classButton!.showBorder = true
        
        self.view.addSubview(classButton!)
        
        // new class label
        let classLabelRect = CGRect(x: self.view.bounds.width * 0.1 + buttonWidth * labelXBufferFactor, y: startingY + classButton!.bounds.height + labelBuffer, width: buttonWidth * (1 - 2*labelXBufferFactor), height: buttonHeight)
        let classLabel = UILabel(frame: classLabelRect)
        classLabel.text = "new class"
        classLabel.textColor = UIColor.white
        classLabel.textAlignment = .center
        self.view.addSubview(classLabel)
        
        // new custom button
        let mid_offset = (x_mid) - (self.view.bounds.width * 0.1 + buttonWidth)
        let customButtonRect = CGRect(x: x_mid + mid_offset, y: startingY, width: buttonWidth, height: buttonHeight)
        customButton = ClassButton(frame: customButtonRect, text: "UROP", hassType: nil, commType: nil, labType: nil)
        customButton!.fillColor = UIColor.flatPurple
        //        customButton!.fillColor = customButton!.fillColor.colorWithAlphaComponent(0.5)
        customButton!.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.view.addSubview(customButton!)
        
        // new custom label
        let customLabelRect = CGRect(x: x_mid + mid_offset + buttonWidth * labelXBufferFactor, y: startingY + classButton!.bounds.height + labelBuffer, width: buttonWidth * (1 - 2*labelXBufferFactor), height: buttonHeight)
        let customLabel = UILabel(frame: customLabelRect)
        customLabel.text = "custom"
        customLabel.textColor = UIColor.white
        customLabel.textAlignment = .center
        self.view.addSubview(customLabel)
        
        // new placeholder button
        let placeholderButtonRect = CGRect(x: x_mid - buttonWidth / 2, y: classLabelRect.maxY + labelBuffer + 4, width: buttonWidth, height: buttonHeight)
        placeholderButton = ClassButton(frame: placeholderButtonRect, text: "P", hassType: nil, commType: nil, labType: nil)
        placeholderButton!.fillColor = UIColor.flatSkyBlue
        placeholderButton!.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        self.view.addSubview(placeholderButton!)
        
        // new placeholder label
        let placeholderLabelRect = CGRect(x: placeholderButtonRect.minX + 10, y: placeholderButton!.frame.maxY + labelBuffer, width: buttonWidth * (1 - 2*labelXBufferFactor) + 7, height: buttonHeight)
        placeholderLabel = UILabel(frame: placeholderLabelRect)
        placeholderLabel!.text = "placeholder"
        placeholderLabel!.textColor = UIColor.white
        placeholderLabel!.textAlignment = .center
        self.view.addSubview(placeholderLabel!)
        
        
        
        //
        //        // new multi button
        //        let multiButtonRect = CGRect(x: customButtonRect.minX, y: placholderButtonRect.minY, width: buttonWidth, height: buttonHeight)
        //        multiButton = ClassButton(frame: multiButtonRect, text: "5.111/7.016", hassType: nil, commType: nil, labType: nil)
        //        multiButton!.fillColor = UIColor.flatPinkColorDark()
        //        multiButton!.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
        //
        //        self.view.addSubview(multiButton!)
        //
        //        // new multi label
        //        let multiLabelRect = CGRect(x: customLabelRect.minX, y: placeholderLabelRect.minY, width: buttonWidth * (1 - 2*labelXBufferFactor), height: buttonHeight)
        //        let multiLabel = UILabel(frame: multiLabelRect)
        //        multiLabel.text = "multi-class"
        //        multiLabel.textColor = UIColor.whiteColor()
        //        multiLabel.textAlignment = .Center
        //        self.view.addSubview(multiLabel)
        
        self.buttons = [classButton!, customButton!, placeholderButton!]
        
        // select label
        let selectLabelRect = CGRect(x: x_mid - selectLabelWidth / 2, y: self.view.bounds.height * 0.57, width: selectLabelWidth, height: buttonHeight)
        selectLabel = UILabel(frame: selectLabelRect)
        selectLabel!.text = "select type of class to add"
        selectLabel!.textColor = UIColor.white
        selectLabel!.textAlignment = .center
        self.view.addSubview(selectLabel!)
        
        // Cancel Button
        let buttonSize: CGFloat = 50
        let cancel_x = x_mid - buttonSize / 2
        let cancelYBuffer: CGFloat = 30
        
        let cancelRect = CGRect(x: cancel_x, y: self.view.bounds.height - borderBuffer - cancelYBuffer - buttonSize, width: buttonSize, height: buttonSize)
        let cancelImage = UIImageView(frame: cancelRect)
        cancelImage.image = Globals.Icons.cancelIcon
        
        let cancelTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancelPressed))
        cancelTapRecognizer.delegate = self
        cancelImage.addGestureRecognizer(cancelTapRecognizer)
        cancelImage.isUserInteractionEnabled = true
        self.view.addSubview(cancelImage)
        
        
        // CUSTOM UI
        let minYBuffer: CGFloat = 175
        startingY = max(self.view.bounds.height * 0.35, classButton!.bounds.maxY + minYBuffer)
        let startingX = self.view.bounds.width * 0.1
        let displayWidth = self.view.bounds.width * 0.8
        let colorButtonSize: CGFloat = self.view.bounds.height > 600 ? 50 : 44
        let buttonColumnBuffer = (displayWidth - (CGFloat(colorChoices.count) * colorButtonSize)) / (CGFloat(colorChoices.count - 1))
        print(self.view.bounds.height)//568, 667, 736
        
        // Color Buttons
        var column: CGFloat = 0
        var first = true
        for color in self.colorChoices {
            
            let schemeRect = CGRect(x: startingX + column*(colorButtonSize + buttonColumnBuffer), y: startingY, width: colorButtonSize, height: colorButtonSize)
            let schemer = SchemeButton(frame: schemeRect)
            schemer.colorOne = color
            schemer.colorTwo = color
            
            if first {
                schemer.showBorder = true
                first.toggle()
            }
            
            self.colorButtons.append(schemer)
            self.customUIBucket.append(schemer)
            column += 1
            schemer.isHidden = true
            
            schemer.addTarget(self, action: #selector(colorSelected), for: .touchUpInside)
            
            self.view.addSubview(schemer)
        }
        
        // Text Input Field
        let textHeight: CGFloat = isSmallPhone ? 40 : 50
        
        let inputTextRect = CGRect(x: startingX, y: startingY + colorButtonSize + customRowBuffer, width: self.view.bounds.width * 0.8, height: textHeight)
        inputTextField = UITextField(frame: inputTextRect)
        inputTextField!.delegate = self
        inputTextField!.placeholder = "UROP"
        inputTextField!.isHidden = true
        inputTextField!.backgroundColor = UIColor.white
        inputTextField!.borderStyle = .roundedRect
        inputTextField!.font = UIFont(name: Globals.Fonts.systemThin, size: 24)
        inputTextField!.returnKeyType = .done
        
        customUIBucket.append(inputTextField!)
        classUIBucket.append(inputTextField!)
        self.view.addSubview(inputTextField!)
        
        // Num Units Field
        let numUnitsWidth = 80.toCGFloat
        let numUnitsRect = CGRect(x: x_mid - numUnitsWidth / 2, y: inputTextField!.frame.maxY + customRowBuffer - (isSmallPhone ? 8 : 0), w: numUnitsWidth, h: textHeight)
        
        numUnitsTextField = UITextField(frame: numUnitsRect)
        numUnitsTextField!.delegate = self
        numUnitsTextField!.placeholder = "# units"
        numUnitsTextField!.isHidden = true
        numUnitsTextField!.backgroundColor = UIColor.white
        numUnitsTextField!.borderStyle = .roundedRect
        numUnitsTextField!.font = UIFont(name: Globals.Fonts.systemThin, size: 22)
        numUnitsTextField!.keyboardType = .numberPad
        
        customUIBucket.append(numUnitsTextField!)
        self.view.addSubview(numUnitsTextField!)
        
        
        // Continue Button
        let continueRect = CGRect(x: cancel_x, y: max(cancelImage.frame.y - borderBuffer - buttonSize, isSmallPhone ? numUnitsTextField!.frame.maxY + 20 : 0), w: buttonSize, h: buttonSize)
        continueImage = UIImageView(frame: continueRect)
        continueImage!.image = Globals.Icons.checkIcon
        
        let continueTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(continuePressed))
        continueTapRecognizer.delegate = self
        continueImage!.addGestureRecognizer(continueTapRecognizer)
        continueImage!.isUserInteractionEnabled = false
        continueImage!.alpha = 0.5
        self.view.addSubview(continueImage!)
        
        // CLASS UI
        // Collection View Controller
        let collectionViewRect = CGRect(x: borderBuffer, y: classLabel.frame.maxY + borderBuffer*0.7 + 50, w: view.w - 2*borderBuffer, h: continueImage!.frame.minY - (classLabel.frame.maxY + borderBuffer*0.7 + 50) - borderBuffer)
        
        collectionView = UICollectionView(frame: collectionViewRect, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView!.backgroundColor = UIColor.flatPowderBlue
        collectionView!.isHidden = true
        
//        collectionViewController = ClassSearchCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        classUIBucket.append(collectionView!)
        //        view.addSubview(collectionView!)
        
        // SearchController and Bar
        searchController = UISearchController(searchResultsController: storyboard?.instantiateViewController(withIdentifier: "ClassSearch"))
        searchController!.searchResultsUpdater = self
        searchController!.delegate = self
        
        
        searchBar = searchController!.searchBar
        searchBarRect = CGRect(x: borderBuffer, y: classLabel.frame.maxY + borderBuffer*0.7, w: view.frame.width - 2*borderBuffer, h: 50)
        searchBar!.frame = searchBarRect!
        searchBar!.isHidden = true
        searchBar!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        searchBar!.delegate = self
        
        classUIBucket.append(searchBar!)
        //        view.addSubview(searchBar!)
        
        
        
        // TapRecognier to dismiss keyboard
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(userDidTapView))
        tapRecognizer.delegate = self
        view.addGestureRecognizer(tapRecognizer)
        
        
        
        // Keyboard Notifications Reg
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Class Text Notification Label
        let infoRect = CGRect(x: startingX, y: inputTextField!.frame.maxY + 5, w: view.w * 0.8, h: 20)
        infoLabel = UILabel(frame: infoRect)
        infoLabel!.text = ""
        infoLabel!.textColor = UIColor.white
        infoLabel!.isHidden = true
        infoLabel!.textAlignment = .right
        classUIBucket.append(infoLabel!)
        
        view.addSubview(infoLabel!)
        
        
        
        
        //        classUIBucket.append(placeholderButton)
        //        classUIBucket.append(placeholderLabel)
        //        customUIBucket.append(placeholderButton!)
        //        customUIBucket.append(placeholderLabel)
        //        placeholderButton!.hidden = true
    }
    
    func buttonPressed(_ sender: ClassButton) {
        self.selectLabel?.isHidden = true
        //
        //        let other = sender == classButton! ? customButton! : classButton!
        //
        //        sender.showBorder = true
        //        sender.fillColor = sender.fillColor.colorWithAlphaComponent(1.0)
        //        sender.userInteractionEnabled = false
        //
        //        other.showBorder = false
        //        other.fillColor = other.fillColor.colorWithAlphaComponent(0.5)
        //        other.userInteractionEnabled = true
        //
        //        sender.setNeedsDisplay()
        //        other.setNeedsDisplay()
        
        for button in buttons {
            if button != sender {
                print("eyy")
                button.showBorder = false
                button.fillColor = button.fillColor.withAlphaComponent(0.5)
                button.isUserInteractionEnabled = true
            } else {
                button.showBorder = true
                button.fillColor = button.fillColor.withAlphaComponent(1.0)
                button.isUserInteractionEnabled = false
            }
            
            button.setNeedsDisplay()
        }
        
        if sender == customButton! {
            displayCustomUI()
        } else if sender == classButton! {
            displayClassUI()
        } else {
            resetUI()
            performSegue(withIdentifier: "PickPlaceholder", sender: self)
        }
    }
    
    func cancelPressed(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func continuePressed(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "PlaceNewClass", sender: self)
    }
    
    func colorSelected(_ sender: SchemeButton) {
        for button in colorButtons {
            button.showBorder = false
        }
        sender.showBorder = true
        
        selectedColor = sender.colorOne
    }
    
    func displayClassUI() {
        hideCustomUI()
        
        placeholderButton!.isHidden = true
        placeholderLabel!.isHidden = true
        
        for view in classUIBucket {
            view!.isHidden = false
        }
        inputTextField!.placeholder = "18.03"
    }
    
    func displayCustomUI() {
        hideClassUI()
        
        placeholderButton!.isHidden = true
        placeholderLabel!.isHidden = true
        
        for view in customUIBucket {
            view.isHidden = false
        }
        inputTextField!.placeholder = "UROP"
    }
    
    func hideClassUI() {
        //        placeholderButton!.hidden = true
        //        placeholderButton!.setNeedsDisplay()
        for view in classUIBucket {
            view!.isHidden = true
        }
    }
    
    func hideCustomUI() {
        for view in customUIBucket {
            view.isHidden = true
        }
    }
    
    func resetUI() {
        for button in buttons {
            button.showBorder = false
            button.isUserInteractionEnabled = true
            button.fillColor = button.fillColor.withAlphaComponent(1.0)
            button.setNeedsDisplay()
        }
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height / 3
                self.titleLabel.isHidden = true
            }
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height / 3
                self.titleLabel.isHidden = false
            }
        }
    }
    
    func userDidTapView(_ sender: UITapGestureRecognizer) {
        if inputTextField!.isFirstResponder {
            inputTextField!.resignFirstResponder()
        } else if numUnitsTextField!.isFirstResponder {
            numUnitsTextField!.resignFirstResponder()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar!.frame = searchBarRect!
    }
    
}

// MARK- UITextFieldDelegate
extension AddClassesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if inputValid() {
            continueImage!.alpha = 1
            infoLabel!.text = ""
        } else {
            continueImage!.alpha = 0.5
            infoLabel!.text = "invalid class"
        }
    }
    
    func inputValid() -> Bool {
        return false
    }
}

extension AddClassesViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
}
