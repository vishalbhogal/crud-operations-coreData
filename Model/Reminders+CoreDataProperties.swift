//
//  Reminders+CoreDataProperties.swift
//  coredata-demo
//
//  Created by Vishal, Bhogal (B.) on 02/06/22.
//
//

import Foundation
import CoreData


extension Reminders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminders> {
        return NSFetchRequest<Reminders>(entityName: "Reminders")
    }

    @NSManaged public var item: String?

}

extension Reminders : Identifiable {

}
