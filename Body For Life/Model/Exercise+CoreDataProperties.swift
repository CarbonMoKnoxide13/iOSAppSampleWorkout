//
//  Exercise+CoreDataProperties.swift
//  Body For Life
//
//  Created by Aramis Knox on 7/2/19.
//  Copyright © 2019 Aramis Knox. All rights reserved.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var reps: NSSet?
    @NSManaged public var workout: Workout?

}

// MARK: Generated accessors for reps
extension Exercise {

    @objc(addRepsObject:)
    @NSManaged public func addToReps(_ value: Rep)

    @objc(removeRepsObject:)
    @NSManaged public func removeFromReps(_ value: Rep)

    @objc(addReps:)
    @NSManaged public func addToReps(_ values: NSSet)

    @objc(removeReps:)
    @NSManaged public func removeFromReps(_ values: NSSet)

}
