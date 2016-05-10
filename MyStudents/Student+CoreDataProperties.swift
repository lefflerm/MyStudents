//
//  Student+CoreDataProperties.swift
//  MyStudents
//
//  Created by student on 5/10/16.
//  Copyright © 2016 student. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Student {

    @NSManaged var first: String
    @NSManaged var last: String
    @NSManaged var course: String
    @NSManaged var gpa: String

}
