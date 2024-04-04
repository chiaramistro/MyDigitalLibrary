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
    let type: WorkTypeKey?
    let subjects: [String]?
    let covers: [Int]?
    let firstSentence: WorkTypeKey?
    let firstPublishDate: String?
    let excerpts: [WorkExcerpt]?
    let description: WorkTypeKey?
    let subjectPlaces, subjectPeople: [String]?
    let location: String?
    let latestRevision, revision: Int?
    let created, lastModified: WorkTypeKey?

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

// MARK: - WorkAuthor
struct WorkAuthor: Codable {
    let type: WorkTypeKey?
    let author: WorkTypeKey?
}

// MARK: - WorkTypeKey
struct WorkTypeKey: Codable {
    let key: String?
    let value: String?
}

// MARK: - WorkExcerpt
struct WorkExcerpt: Codable {
    let excerpt, page, comment: String?
}
