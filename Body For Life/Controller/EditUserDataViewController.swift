//
//  EditUserDataViewController.swift
//  Body For Life
//
//  Created by Aramis Knox on 8/27/19.
//  Copyright © 2019 Aramis Knox. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditUserDataViewController: UIViewController {
    
    var managedContext: NSManagedObjectContext!
    var tableView: UITableView!
    var managedObjects: [NSManagedObject]!
    
    func delete(cellForRowAt indexPath: IndexPath) {
        self.managedContext.delete(self.managedObjects[indexPath.row])
        self.managedObjects.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.save()
    }
    
    func save() {
        do {
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
    }
    
}
