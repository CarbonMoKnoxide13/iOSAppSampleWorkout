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

class RepsViewController : EditUserDataViewController, UITableViewDelegate, UITableViewDataSource {
    
    //var exercise : Exercise?
    
    func initializeProperties() {
        
        tableView = {
            let tv = UITableView()
            tv.backgroundColor = UIColor(rgb: 0x2C4E86)
            tv.translatesAutoresizingMaskIntoConstraints = false
            tv.register(RepsCell.self, forCellReuseIdentifier: "reps")
            return tv
        }()
        
        //managedObjects = exercise!.reps!.allObjects as! [NSManagedObject]
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
        
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
    }
    
    @objc func addButtonTapped(_ Sender: UIBarButtonItem) {
        var newRep = Rep(context: managedContext)
        newRep.date = NSDate()
        managedObjects!.append(newRep)
        self.save()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        initializeProperties()
        
        managedContext = appDelegate.persistentContainer.viewContext
        
        tableView.dataSource = self
        tableView.delegate = self
        setupNavigationController()
        setupTableView()
    }
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x64AB23)
        //navigationItem.title = exercise!.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managedObjects!.count //Add reps to exercise
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reps", for: indexPath) as! RepsCell
        cell.rep = managedObjects[indexPath.row] as! Rep
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editRepViewController = EditRepViewController()
        editRepViewController.repsViewControllerReference = self
        editRepViewController.elementIndex = indexPath.row
        navigationController?.pushViewController(editRepViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.delete(cellForRowAt: indexPath)
        }
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
