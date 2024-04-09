//
//  AuthorResponse.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 04/04/24.
//

import Foundation

// MARK: - AuthorResponse
struct AuthorResponse: Codable {
    let name, title: String?
    let key: String?
    let links: [AuthorLink]?
    let bio: TypeKeyEnum?
    let type: TypeKey?
    let alternateNames: [String]?
    let photos: [Int]?
    let wikipedia: String?
    let personalName, entityType, birthDate: String?
    let sourceRecords: [String]?
    let fullerName: String?
    let remoteIDS: AuthorRemoteIDS?
    let latestRevision, revision: Int?
    let created, lastModified: TypeKey?

    enum CodingKeys: String, CodingKey {
        case name, title, links, bio, type
        case alternateNames = "alternate_names"
        case photos, wikipedia
        case personalName = "personal_name"
        case entityType = "entity_type"
        case birthDate = "birth_date"
        case sourceRecords = "source_records"
        case key
        case fullerName = "fuller_name"
        case remoteIDS = "remote_ids"
        case latestRevision = "latest_revision"
        case revision, created
        case lastModified = "last_modified"
    }
}

extension AuthorResponse {
    func displayBio() -> String {
        guard let bio = bio else {
            return "Bio not available"
        }
        
        switch bio {
        case .string(let string):
            return string
        case .typeKey(let typeKey):
            return typeKey.value ?? "-"
        }
    }
}

// MARK: - Link
struct AuthorLink: Codable {
    let title: String?
    let url: String?
    let type: TypeKey?
}

// MARK: - AuthorRemoteIDS
struct AuthorRemoteIDS: Codable {
    let viaf, goodreads, storygraph, isni: String?
    let librarything, amazon, wikidata: String?
}
