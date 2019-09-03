//
//  Rep+CoreDataProperties.swift
//  Body For Life
//
//  Created by Aramis Knox on 7/31/19.
//  Copyright © 2019 Aramis Knox. All rights reserved.
//
//

import Foundation
import CoreData


extension Rep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rep> {
        return NSFetchRequest<Rep>(entityName: "Rep")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var intensity: Float
    @NSManaged public var reps: Float
    @NSManaged public var weight: Float
    @NSManaged public var exercise: Exercise?

}
