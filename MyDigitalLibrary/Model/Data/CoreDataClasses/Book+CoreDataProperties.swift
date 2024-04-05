//
//  Book+CoreDataProperties.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 05/04/24.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var cover: Data?
    @NSManaged public var coverKey: String?
    @NSManaged public var key: String?
    @NSManaged public var title: String?
    @NSManaged public var trama: String?
    @NSManaged public var author: Author?

}

extension Book : Identifiable {

}
