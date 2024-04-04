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
    let links: [AuthorLink]?
    let bio: String?
    let type: AuthorTypeKey?
    let alternateNames: [String]?
    let photos: [Int]?
    let wikipedia: String?
    let personalName, entityType, birthDate: String?
    let sourceRecords: [String]?
    let key, fullerName: String?
    let remoteIDS: AuthorRemoteIDS?
    let latestRevision, revision: Int?
    let created, lastModified: AuthorTypeKey?

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

// MARK: - AuthorTypeKey
struct AuthorTypeKey: Codable {
    let key: String?
    let type, value: String?
}

// MARK: - Link
struct AuthorLink: Codable {
    let title: String?
    let url: String?
    let type: AuthorTypeKey?
}

// MARK: - AuthorRemoteIDS
struct AuthorRemoteIDS: Codable {
    let viaf, goodreads, storygraph, isni: String?
    let librarything, amazon, wikidata: String?
}
