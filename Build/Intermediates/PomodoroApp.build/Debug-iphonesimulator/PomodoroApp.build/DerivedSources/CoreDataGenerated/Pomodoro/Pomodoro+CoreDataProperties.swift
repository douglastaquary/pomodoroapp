//
//  Pomodoro+CoreDataProperties.swift
//  
//
//  Created by Douglas Taquary on 29/08/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Pomodoro {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pomodoro> {
        return NSFetchRequest<Pomodoro>(entityName: "Pomodoro")
    }

    @NSManaged public var relativeTime: NSDate?
    @NSManaged public var state: String?
    @NSManaged public var timer: String?

}
