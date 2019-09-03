//
//  WorkoutViewController.swift
//  Body For Life
//
//  Created by Aramis Knox on 6/30/19.
//  Copyright © 2019 Aramis Knox. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class WorkoutViewController : UIViewController, UITextFieldDelegate {
    
    var managedContext : NSManagedObjectContext!
    
    var workout : Workout?
    var index : Int?
    var repIndex : Int?
    var selectedExercise : Exercise?
    var selectedRep : Rep?
    
    let titleView: UILabel = {
        let label = UILabel()
        label.text = "Exercise Name"
        label.textColor = UIColor(rgb: 0x64AB23)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Avenir-Heavy", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let expectedWeightView: UILabel = {
        let label = UILabel()
        label.text = "Expected Weight: "
        label.textColor = UIColor(rgb: 0x64AB23)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Avenir-Heavy", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let expectedRepView: UILabel = {
        let label = UILabel()
        label.text = "Expected Reps: "
        label.textColor = UIColor(rgb: 0x64AB23)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Avenir-Heavy", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let expectedIntensityView: UILabel = {
        let label = UILabel()
        label.text = "Expected Intensity: "
        label.textColor = UIColor(rgb: 0x64AB23)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Avenir-Heavy", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let adjustWeightButton : UIButton = {
        let button = UIButton()
        button.setTitle("Adjust Weight", for: .normal)
        button.setTitleColor(UIColor(rgb: 0x64AB23), for: .normal)
        button.titleLabel?.font =  UIFont(name: "Avenir-Heavy", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let adjustRepsButton : UIButton = {
        let button = UIButton()
        button.setTitle("Adjust Reps", for: .normal)
        button.setTitleColor(UIColor(rgb: 0x64AB23), for: .normal)
        button.titleLabel?.font =  UIFont(name: "Avenir-Heavy", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let adjustIntensityButton : UIButton = {
        let button = UIButton()
        button.setTitle("Adjust Intensity", for: .normal)
        button.setTitleColor(UIColor(rgb: 0x64AB23), for: .normal)
        button.titleLabel?.font =  UIFont(name: "Avenir-Heavy", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nextButton : UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(rgb: 0x64AB23), for: .normal)
        button.titleLabel?.font =  UIFont(name: "Avenir-Heavy", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        index = 0
        repIndex = 0
        
        selectedExercise = workout!.exercises!.allObjects[index!] as! Exercise
        selectedRep = selectedExercise!.reps!.allObjects[repIndex!] as! Rep
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        managedContext = appDelegate.persistentContainer.viewContext
        
        titleView.text! = "\(selectedExercise!.title!)"
        expectedWeightView.text! = "Expected Weight: \(selectedRep!.weight)"
        expectedRepView.text! = "Expected Reps: \(selectedRep!.reps)"
        expectedIntensityView.text! = "Expected Intensity: \(selectedRep!.intensity)"
        
        setupViews()
    }
    
    public func setupViews() {
        view.addSubview(titleView)
        view.addSubview(expectedWeightView)
        view.addSubview(adjustWeightButton)
        view.addSubview(expectedRepView)
        view.addSubview(adjustRepsButton)
        view.addSubview(expectedIntensityView)
        view.addSubview(adjustIntensityButton)
        view.addSubview(nextButton)
        
        view.backgroundColor = UIColor(rgb: 0x2C4E86)
        
        view.addConstraint(NSLayoutConstraint(item: titleView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: titleView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: expectedWeightView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: expectedWeightView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.5125, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: adjustWeightButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: adjustWeightButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.6125, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: expectedRepView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: expectedRepView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.925, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: adjustRepsButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: adjustRepsButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.025, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: expectedIntensityView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: expectedIntensityView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.34, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: adjustIntensityButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: adjustIntensityButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.44, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.75, constant: 0))
        
        adjustWeightButton.addTarget(self, action: #selector(adjustWeightButtonTapped(_:)), for: .touchUpInside)
        adjustRepsButton.addTarget(self, action: #selector(adjustRepsButtonTapped(_:)), for: .touchUpInside)
        adjustIntensityButton.addTarget(self, action: #selector(adjustIntensityButtonTapped(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    }
    
    func resetData() {
        titleView.text = "\(selectedExercise!.title!)"
        expectedWeightView.text = "Expected Weight: \(selectedRep!.weight)"
        expectedRepView.text = "Expected Reps: \(selectedRep!.reps)"
        expectedIntensityView.text = "Expected Intensity: \(selectedRep!.intensity)"
        
        print(repIndex!)
        print(selectedExercise!.reps!.allObjects.count)
        
        //weightTextField.text! = String(selectedRep!.weight)
        //repsTextField.text! = String(selectedRep!.reps)
        //intensityTextField.text! = String(selectedRep!.intensity)
    }
    
    @objc func adjustWeightButtonTapped(_ Sender: UIButton) {
        print("Adjust Weight")
        let alert = UIAlertController(title: "Adjust Weight", message: "Please enter expected weight for your exercise", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = "\(String(self.selectedRep!.weight))"
            textField.keyboardType = UIKeyboardType.decimalPad
        }
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            var newWeight = Float(textField!.text!)
            self.selectedRep!.weight = Float(newWeight!)
            self.save()
            self.resetData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func adjustRepsButtonTapped(_ Sender: UIButton) {
        print("Adjust Reps")
        let alert = UIAlertController(title: "Adjust Reps", message: "Please enter expected reps for your exercise", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = "\(String(self.selectedRep!.reps))"
            textField.keyboardType = UIKeyboardType.decimalPad
        }
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            var newReps = Float(textField!.text!)
            self.selectedRep!.reps = Float(newReps!)
            self.save()
            self.resetData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func adjustIntensityButtonTapped(_ Sender: UIButton) {
        print("Adjust Intensity")
        let alert = UIAlertController(title: "Adjust Intensity", message: "Please enter expected intensity for your exercise", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = "\(String(self.selectedRep!.intensity))"
            textField.keyboardType = UIKeyboardType.decimalPad
        }
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            var newIntensity = Float(textField!.text!)
            self.selectedRep!.intensity = Float(newIntensity!)
            self.save()
            self.resetData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func nextButtonTapped(_ Sender: UIButton) {
        if(repIndex! + 1 < selectedExercise!.reps!.allObjects.count) {
            print("Next set")
            repIndex = repIndex! + 1
            selectedRep = selectedExercise!.reps!.allObjects[repIndex!] as! Rep
            resetData()
        } else if (index! + 1 < workout!.exercises!.allObjects.count) {
            print("Next exercise")
            repIndex = 0
            index = index! + 1
            selectedExercise = workout!.exercises!.allObjects[index!] as! Exercise
            selectedRep = selectedExercise!.reps!.allObjects[repIndex!] as! Rep
            resetData()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func save() {
        do {
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
    }
}
