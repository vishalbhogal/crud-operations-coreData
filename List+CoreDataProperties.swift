//
//  List+CoreDataProperties.swift
//  coredata-demo
//
//  Created by Vishal, Bhogal (B.) on 02/06/22.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "Reminders")
    }

    @NSManaged public var item: String?

}

extension List : Identifiable {

}
