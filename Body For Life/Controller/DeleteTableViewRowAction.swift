//
//  DeleteTableViewRowAction.swift
//  Body For Life
//
//  Created by Aramis Knox on 8/26/19.
//  Copyright © 2019 Aramis Knox. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DeleteTableViewRowAction: UITableViewRowAction {
    
    //CHANGE INIT TO EDITDATAVIEWCONTROLLER
    
    var viewController: EditUserDataViewController!
    
    init(viewController: EditUserDataViewController) {
        self.viewController = viewController
    }
    
    init(style: UITableViewRowAction.Style, title: String?, handler: (UITableViewRowAction, IndexPath) -> Void) {
        
    }
    
    func delete(cellForRowAt indexPath: IndexPath, in tableView: UITableView) {
        //self.managedContext.delete(self.storedObjects[indexPath.row])
        //self.storedObjects.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
