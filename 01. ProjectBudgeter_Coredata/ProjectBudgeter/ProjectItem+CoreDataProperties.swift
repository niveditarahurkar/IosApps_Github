//
//  ProjectItem+CoreDataProperties.swift
//  ProjectBudgeter
//
//  Created by nirahurk on 7/25/17.
//  Copyright © 2017 IOS learning. All rights reserved.
//

import Foundation
import CoreData


extension ProjectItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectItem> {
        return NSFetchRequest<ProjectItem>(entityName: "ProjectItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Float
    @NSManaged public var quantity: Int32

}
