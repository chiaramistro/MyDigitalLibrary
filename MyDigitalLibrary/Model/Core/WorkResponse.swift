//
//  WorkResponse.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 04/04/24.
//

import Foundation

// MARK: - WorkResponse
struct WorkResponse: Codable {
    let key: String?
    let title: String?
    let authors: [WorkAuthor]?
    let type: TypeKey?
    let subjects: [String]?
    let covers: [Int]?
    let firstSentence: TypeKey?
    let firstPublishDate: String?
    let excerpts: [WorkExcerpt]?
    let description: TypeKeyEnum?
    let subjectPlaces, subjectPeople: [String]?
    let location: String?
    let latestRevision, revision: Int?
    let created, lastModified: TypeKey?

    enum CodingKeys: String, CodingKey {
        case title, key, authors, type, subjects, covers
        case firstSentence = "first_sentence"
        case firstPublishDate = "first_publish_date"
        case excerpts, description
        case subjectPlaces = "subject_places"
        case subjectPeople = "subject_people"
        case location
        case latestRevision = "latest_revision"
        case revision, created
        case lastModified = "last_modified"
    }
}

extension WorkResponse {
    func displayTrama() -> String {
        guard let description = description else {
            return "Trama not available"
        }
        
        switch description {
        case .string(let string):
            return string
        case .typeKey(let typeKey):
            return typeKey.value ?? "-"
        }
    }
}

// MARK: - WorkAuthor
struct WorkAuthor: Codable {
    let type: TypeKey?
    let author: TypeKey?
}

// MARK: - WorkExcerpt
struct WorkExcerpt: Codable {
    let excerpt, page, comment: String?
}
