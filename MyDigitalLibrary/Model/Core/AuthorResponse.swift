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
    let bio: BioType?
    let type: AuthorTypeKey?
    let alternateNames: [String]?
    let photos: [Int]?
    let wikipedia: String?
    let personalName, entityType, birthDate: String?
    let sourceRecords: [String]?
    let fullerName: String?
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

extension AuthorResponse {
    func displayBio() -> String {
        guard let bio = bio else {
            return "Bio not available"
        }
        
        switch bio {
        case .string(let string):
            return string
        case .authorTypeKey(let authorTypeKey):
            return authorTypeKey.value ?? "-"
        }
    }
}

// MARK: - BioType
enum BioType: Codable {
    case string(String)
    case authorTypeKey(AuthorTypeKey)
    
    init(from decoder: Decoder) throws {
        if let string = try? String(from: decoder) {
            self = .string(string)
            return
        }
        if let authorTypeKey = try? AuthorTypeKey(from: decoder) {
            self = .authorTypeKey(authorTypeKey)
            return
        }
        throw DecodingError.dataCorruptedError(in: try decoder.unkeyedContainer(), debugDescription: "Unable to decode BioType")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let string):
            try container.encode(string)
        case .authorTypeKey(let authorTypeKey):
            try container.encode(authorTypeKey)
        }
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
