//
//  EditWorkoutViewController.swift
//  Body For Life
//
//  Created by Aramis Knox on 6/23/19.
//  Copyright © 2019 Aramis Knox. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditWorkoutViewController : EditUserDataViewController, UITableViewDelegate, UITableViewDataSource {
    
    //var managedContext : NSManagedObjectContext!
    
    var workout : Workout?
    
    func initializeProperties() {
        
        tableView = {
            let tv = UITableView()
            tv.translatesAutoresizingMaskIntoConstraints = false
            tv.register(ExerciseCell.self, forCellReuseIdentifier: "exercise") //I need to be able to add cells (ExerciseCell)
            //The model will be Exercise
            return tv
        }()
        
        managedObjects = workout!.exercises!.allObjects as! [NSManagedObject]
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        managedContext = appDelegate.persistentContainer.viewContext
        
        initializeProperties()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(rgb: 0x2C4E86)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x64AB23)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
        navigationItem.title = workout!.title
        setupTableView()
        print(workout!.title)
    }
    
    @objc func addButtonTapped(_ Sender: UIBarButtonItem) {
        var newExercise = Exercise(context: managedContext)
        newExercise.title = "New Exercise"
        newExercise.date = NSDate()
        workout!.addToExercises(newExercise)
        managedObjects.append(newExercise)
        self.save()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managedObjects!.count //workout.exercises.length
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exercise", for: indexPath) as! ExerciseCell
        cell.exercise = managedObjects![indexPath.row] as! Exercise
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repsViewController = RepsViewController()
        //repsViewController.exercise = workout!.exercises!.allObjects[indexPath.row] as! Exercise
        let exercise = workout!.exercises!.allObjects[indexPath.row] as! Exercise
        repsViewController.managedObjects = exercise.reps!.allObjects as! [NSManagedObject]
        repsViewController.navigationItem.title = exercise.title
        navigationController?.pushViewController(repsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete")
        { (rowAction, indexPath) in
            self.delete(cellForRowAt: indexPath)
        }
        
        let renameAction = UITableViewRowAction(style: .normal, title: "Rename") { (rowAction, indexPath) in
            print("Rename")
            let alert = UIAlertController(title: "Rename Exercise", message: "Please enter a new name for your exercise", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = "Exercise Name"
            }
            
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                var itemToRename = self.workout!.exercises!.allObjects[indexPath.row] as! Exercise
                itemToRename.title = textField!.text
                self.save()
                self.managedObjects = self.workout!.exercises!.allObjects as! [NSManagedObject]
                self.tableView.reloadData()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        renameAction.backgroundColor = UIColor(rgb: 0x2C4E86)
        
        return [renameAction, deleteAction]
    }
}
