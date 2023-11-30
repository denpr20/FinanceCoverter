//
//  Response+CoreDataProperties.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 08.11.2023.
//
//

import Foundation
import CoreData


extension Response {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Response> {
        return NSFetchRequest<Response>(entityName: "Response")
    }

    @NSManaged public var success: Bool
    @NSManaged public var timestamp: Int64
    @NSManaged public var base: String?
    @NSManaged public var date: String?
    @NSManaged public var rates: [String: Double]?

}

extension Response : Identifiable {

}
