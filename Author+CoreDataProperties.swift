//
//  Author+CoreDataProperties.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 08/04/24.
//
//

import Foundation
import CoreData


extension Author {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Author> {
        return NSFetchRequest<Author>(entityName: "Author")
    }

    @NSManaged public var bio: String?
    @NSManaged public var key: String?
    @NSManaged public var name: String?
    @NSManaged public var photo: Data?
    @NSManaged public var photoKey: String?
    @NSManaged public var books: Book?

}

extension Author : Identifiable {

}
