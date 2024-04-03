//
//  AuthorSearchResponse.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 03/04/24.
//

import Foundation

// MARK: - AuthorSearchResponse
struct AuthorSearchResponse: Codable {
    let numFound, start: Int
    let numFoundExact: Bool
    let docs: [AuthorBookResponse]
}

// MARK: - AuthorBookResponse
struct AuthorBookResponse: Codable {
    let alternateNames: [String]?
    let birthDate: String?
    let key, name: String
    let topSubjects: [String]?
    let topWork: String?
    let type: String
    let workCount: Int
    let version: Double

    enum CodingKeys: String, CodingKey {
        case alternateNames = "alternate_names"
        case birthDate = "birth_date"
        case key, name
        case topSubjects = "top_subjects"
        case topWork = "top_work"
        case type
        case workCount = "work_count"
        case version = "_version_"
    }
}
