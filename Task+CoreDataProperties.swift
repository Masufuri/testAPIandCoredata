//
//  Task+CoreDataProperties.swift
//  test2
//
//  Created by User1 on 13/05/2025.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var datetime: String?

}

extension Task : Identifiable {

}
