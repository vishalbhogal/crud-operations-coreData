//
//  Items+CoreDataProperties.swift
//  coredata-demo
//
//  Created by Vishal, Bhogal (B.) on 05/06/22.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var reminder: Reminders?

}

extension Items : Identifiable {

}
