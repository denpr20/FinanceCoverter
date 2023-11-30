//
//  Country+CoreDataProperties.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 03.11.2023.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?

}

extension Country : Identifiable {

}
