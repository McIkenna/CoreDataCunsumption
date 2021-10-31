//
//  GamerPower+CoreDataProperties.swift
//  CoreDataCunsumption
//
//  Created by New Account on 10/31/21.
//
//

import Foundation
import CoreData


extension GamerPower {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GamerPower> {
        return NSFetchRequest<GamerPower>(entityName: "GamerPower")
    }

    @NSManaged public var title: String
    @NSManaged public var worth: String

}

extension GamerPower : Identifiable {

}
