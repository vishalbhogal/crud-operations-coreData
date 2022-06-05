//
//  Reminders+CoreDataProperties.swift
//  coredata-demo
//
//  Created by Vishal, Bhogal (B.) on 05/06/22.
//
//

import Foundation
import CoreData


extension Reminders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminders> {
        return NSFetchRequest<Reminders>(entityName: "Reminders")
    }

    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension Reminders {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Items)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Items)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension Reminders : Identifiable {

}
