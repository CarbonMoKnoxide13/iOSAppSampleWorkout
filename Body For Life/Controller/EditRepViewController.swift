//
//  EditRepViewController.swift
//  Body For Life
//
//  Created by Aramis Knox on 6/27/19.
//  Copyright © 2019 Aramis Knox. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditRepViewController: UIViewController, UITextFieldDelegate {
    
    var managedContext : NSManagedObjectContext!
    
    var rep : Rep?
    var repsViewControllerReference : RepsViewController?
    var elementIndex : Int?
    
    let weightView: UILabel = {
        let label = UILabel()
        label.text = "Weight: "
        label.textColor = UIColor(rgb: 0x64AB23)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Avenir-Heavy", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    lazy var weightTextField: UITextField = {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        tf.textColor = UIColor(rgb: 0x2C4E86)
        tf.font = UIFont(name: "Avenir-Heavy", size: 17)
        tf.backgroundColor = UIColor(rgb: 0x60BAE3)
        tf.delegate = self
        tf.keyboardType = UIKeyboardType.decimalPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let repView: UILabel = {
        let label = UILabel()
        label.text = "Reps: "
        label.textColor = UIColor(rgb: 0x64AB23)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Avenir-Heavy", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    lazy var repsTextField: UITextField = {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        tf.textColor = UIColor(rgb: 0x2C4E86)
        tf.font = UIFont(name: "Avenir-Heavy", size: 17)
        tf.backgroundColor = UIColor(rgb: 0x60BAE3)
        tf.delegate = self
        tf.keyboardType = UIKeyboardType.decimalPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let intensityView: UILabel = {
        let label = UILabel()
        label.text = "Intensity: "
        label.textColor = UIColor(rgb: 0x64AB23)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Avenir-Heavy", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    lazy var intensityTextField: UITextField = {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        tf.textColor = UIColor(rgb: 0x2C4E86)
        tf.font = UIFont(name: "Avenir-Heavy", size: 17)
        tf.backgroundColor = UIColor(rgb: 0x60BAE3)
        tf.delegate = self
        tf.keyboardType = UIKeyboardType.decimalPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let doneButton : UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor(rgb: 0x64AB23), for: .normal)
        button.titleLabel?.font =  UIFont(name: "Avenir-Heavy", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        managedContext = appDelegate.persistentContainer.viewContext
        
        setupViews()
    }
    
    public func setupViews() {
        view.addSubview(weightView)
        view.addSubview(weightTextField)
        view.addSubview(repView)
        view.addSubview(repsTextField)
        view.addSubview(intensityView)
        view.addSubview(intensityTextField)
        view.addSubview(doneButton)
        
        setupToolbar()
        
        view.backgroundColor = UIColor(rgb: 0x2C4E86)
        
        view.addConstraint(NSLayoutConstraint(item: weightView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: weightView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.25, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: weightTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: weightTextField, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.25, constant: 50))
        view.addConstraint(NSLayoutConstraint(item: weightTextField, attribute: .width, relatedBy: .equal, toItem: weightTextField, attribute: .width, multiplier: 0, constant: UIScreen.main.bounds.width - 100))
        
        view.addConstraint(NSLayoutConstraint(item: repView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: repView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.75, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: repsTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: repsTextField, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.75, constant: 50))
        view.addConstraint(NSLayoutConstraint(item: repsTextField, attribute: .width, relatedBy: .equal, toItem: repsTextField, attribute: .width, multiplier: 0, constant: UIScreen.main.bounds.width - 100))
        
        view.addConstraint(NSLayoutConstraint(item: intensityView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: intensityView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.25, constant: 0))
    
        view.addConstraint(NSLayoutConstraint(item: intensityTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: intensityTextField, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.25, constant: 50))
        view.addConstraint(NSLayoutConstraint(item: intensityTextField, attribute: .width, relatedBy: .equal, toItem: intensityTextField, attribute: .width, multiplier: 0, constant: UIScreen.main.bounds.width - 100))
        
        view.addConstraint(NSLayoutConstraint(item: doneButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: doneButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.75, constant: 0))
        
        doneButton.addTarget(self, action: #selector(unwindToRepsViewController(_:)), for: .touchUpInside)
    }
    
    @objc func unwindToRepsViewController(_ Sender: UIButton) {
        let weight = Float(weightTextField.text!)
        let reps = Float(repsTextField.text!)
        let intensity = Float(intensityTextField.text!)
        var repReference = repsViewControllerReference!.managedObjects[elementIndex!] as! Rep
        repReference.weight = Float(weight!)
        repReference.reps = Float(reps!)
        repReference.intensity = Float(intensity!)
        self.save()
        navigationController?.popViewController(animated: true)
        //print("Button pressed!")
    }
    
    @objc func doneButtonAction(_ Sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    func setupToolbar() {
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction(_:)))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        self.weightTextField.inputAccessoryView = toolbar
        self.repsTextField.inputAccessoryView = toolbar
        self.intensityTextField.inputAccessoryView = toolbar
    }
    
    func save() {
        
        print("Attempting to save")
        
        do {
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
