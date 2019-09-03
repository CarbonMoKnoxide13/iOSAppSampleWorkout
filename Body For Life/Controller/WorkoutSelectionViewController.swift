//
//  WorkoutSelectionViewController.swift
//  Body For Life
//
//  Created by Aramis Knox on 6/21/19.
//  Copyright © 2019 Aramis Knox. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class WorkoutSelectionViewController: EditUserDataViewController, UITableViewDelegate, UITableViewDataSource {
    
    func initializeProperties() {
    
        tableView = {
            let tv = UITableView()
            tv.translatesAutoresizingMaskIntoConstraints = false
            tv.register(WorkoutCell.self, forCellReuseIdentifier: "cellId")
            return tv
        }()
    
        managedObjects = []
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(rgb: 0x2C4E86)
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
    }
    
    fileprivate func setupNavigationController() {
        navigationItem.title = "Workouts"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x64AB23)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        managedContext = appDelegate.persistentContainer.viewContext
        
        initializeProperties()
        setupNavigationController()
        setupTableView()
        retrieveWorkoutData()
    }
    
    @objc func addButtonTapped(_ Sender: UIBarButtonItem) {
        let newWorkout = Workout(context: managedContext)
        newWorkout.title = "New Workout"
        newWorkout.date = NSDate()
        managedObjects.append(newWorkout)
        self.save()
        tableView.reloadData()
    }
    
    @objc func segueToEditWorkoutView(_ Sender: EditWorkoutButton) {
        let editWorkoutViewController = EditWorkoutViewController()
        editWorkoutViewController.workout = Sender.workout
        navigationController?.pushViewController(editWorkoutViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managedObjects.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! WorkoutCell
        cell.workout = (managedObjects[indexPath.row] as! Workout)
        cell.editWorkoutView.addTarget(self, action: #selector(segueToEditWorkoutView(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workoutController = WorkoutViewController()
        workoutController.workout = (managedObjects[indexPath.row] as! Workout)
        navigationController!.pushViewController(workoutController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {
            (rowAction, indexPath) in
            tableView.beginUpdates()
            self.delete(cellForRowAt: indexPath)
            tableView.endUpdates()
        }
        
        let renameAction = UITableViewRowAction(style: .normal, title: "Rename") { (rowAction, indexPath) in
            let alert = self.setupRenameAlert(indexPath: indexPath)
            self.present(alert, animated: true, completion: nil)
        }
        
        renameAction.backgroundColor = UIColor(rgb: 0x2C4E86)
        return [renameAction, deleteAction]
    }
    
    func setupRenameAlert(indexPath: IndexPath) -> UIAlertController { //TODO: Refactor this into EditUserDataViewController
        let alert = UIAlertController(title: "Rename Workout", message: "Please enter a new name for your workout", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = "Workout Name"
        }
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let workout = self.managedObjects[indexPath.row] as! Workout
            workout.title = textField!.text
            self.save()
            self.tableView.reloadData()
        }))
        
        return alert
    }
    
    func retrieveWorkoutData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Workout")
        let sort = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sort]
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            for data in result as! [Workout] {
                managedObjects.append(data)
            }
        } catch {
            print("Failed to retrieve workout data")
        }
    }
}
