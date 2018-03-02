//
//  Present+CoreDataProperties.swift
//  presentbase1
//
//  Created by Lenah Syed on 3/1/17.
//  Copyright © 2017 Lenah Syed. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Present {

    @NSManaged var image: Data?
    @NSManaged var person: String?
    @NSManaged var present: String?
    @NSManaged var info: String?
    @NSManaged var location: String?
    @NSManaged var date: Date?
}
