//
//  BookSearchResponse.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import Foundation

// MARK: - BookSearchResponse
struct BookSearchResponse: Codable {
    let numFound, start: Int
    let numFoundExact: Bool
    let docs: [BookResponse]
    let eventsResponseNumFound: Int
    let q: String
    let offset: Int?

    enum CodingKeys: String, CodingKey {
        case numFound, start, numFoundExact, docs
        case eventsResponseNumFound = "num_found"
        case q, offset
    }
}

// MARK: - Book
struct BookResponse: Codable {
    let authorAlternativeName, authorKey, authorName, contributor: [String]?
    let coverEditionKey: String?
    let coverI: Int?
    let ddc: [String]?
    let ebookAccess: String
    let ebookCountI, editionCount: Int
    let editionKey: [String]?
    let firstPublishYear: Int?
    let firstSentence: [String]?
    let hasFulltext: Bool
    let ia, iaCollection: [String]?
    let iaCollectionS: String?
    let isbn: [String]?
    let key: String
    let language: [String]?
    let lastModifiedI: Int
    let lcc, lccn: [String]?
    let lendingEditionS, lendingIdentifierS: String?
    let numberOfPagesMedian: Int?
    let oclc: [String]?
    let printdisabledS: String?
    let publicScanB: Bool
    let publishDate, publishPlace: [String]?
    let publishYear: [Int]?
    let publisher: [String]?
    let seed: [String]
    let title, titleSort, titleSuggest: String
    let type: String
    let idLibrarything, idGoodreads, idAmazon, idDepósitoLegal: [String]?
    let idAlibrisID, idGoogle, idPaperbackSwap, idWikidata: [String]?
    let idOverdrive, idCanadianNationalLibraryArchive, subject, place: [String]?
    let time, person, iaLoadedID, iaBoxID: [String]?
    let ratingsAverage, ratingsSortable: Double?
    let ratingsCount, ratingsCount1, ratingsCount2, ratingsCount3: Int?
    let ratingsCount4, ratingsCount5, readinglogCount, wantToReadCount: Int?
    let currentlyReadingCount, alreadyReadCount: Int?
    let publisherFacet, personKey, placeKey, timeFacet: [String]?
    let personFacet, subjectFacet: [String]?
    let version: Double
    let placeFacet: [String]?
    let lccSort: String?
    let authorFacet, subjectKey, timeKey: [String]?
    let ddcSort: String?
    let idNla, idAmazonCoUkAsin, idAmazonCAAsin, idAmazonDeAsin: [String]?
    let idBetterWorldBooks, idBritishNationalBibliography, idAmazonItAsin, idBcid: [String]?
    let idScribd, idHathiTrust, idBritishLibrary, idBibliothèqueNationaleDeFrance: [String]?
    let idLibris, idDnb: [String]?
    let subtitle: String?

    enum CodingKeys: String, CodingKey {
        case authorAlternativeName = "author_alternative_name"
        case authorKey = "author_key"
        case authorName = "author_name"
        case contributor
        case coverEditionKey = "cover_edition_key"
        case coverI = "cover_i"
        case ddc
        case ebookAccess = "ebook_access"
        case ebookCountI = "ebook_count_i"
        case editionCount = "edition_count"
        case editionKey = "edition_key"
        case firstPublishYear = "first_publish_year"
        case firstSentence = "first_sentence"
        case hasFulltext = "has_fulltext"
        case ia
        case iaCollection = "ia_collection"
        case iaCollectionS = "ia_collection_s"
        case isbn, key, language
        case lastModifiedI = "last_modified_i"
        case lcc, lccn
        case lendingEditionS = "lending_edition_s"
        case lendingIdentifierS = "lending_identifier_s"
        case numberOfPagesMedian = "number_of_pages_median"
        case oclc
        case printdisabledS = "printdisabled_s"
        case publicScanB = "public_scan_b"
        case publishDate = "publish_date"
        case publishPlace = "publish_place"
        case publishYear = "publish_year"
        case publisher, seed, title
        case titleSort = "title_sort"
        case titleSuggest = "title_suggest"
        case type
        case idLibrarything = "id_librarything"
        case idGoodreads = "id_goodreads"
        case idAmazon = "id_amazon"
        case idDepósitoLegal = "id_depósito_legal"
        case idAlibrisID = "id_alibris_id"
        case idGoogle = "id_google"
        case idPaperbackSwap = "id_paperback_swap"
        case idWikidata = "id_wikidata"
        case idOverdrive = "id_overdrive"
        case idCanadianNationalLibraryArchive = "id_canadian_national_library_archive"
        case subject, place, time, person
        case iaLoadedID = "ia_loaded_id"
        case iaBoxID = "ia_box_id"
        case ratingsAverage = "ratings_average"
        case ratingsSortable = "ratings_sortable"
        case ratingsCount = "ratings_count"
        case ratingsCount1 = "ratings_count_1"
        case ratingsCount2 = "ratings_count_2"
        case ratingsCount3 = "ratings_count_3"
        case ratingsCount4 = "ratings_count_4"
        case ratingsCount5 = "ratings_count_5"
        case readinglogCount = "readinglog_count"
        case wantToReadCount = "want_to_read_count"
        case currentlyReadingCount = "currently_reading_count"
        case alreadyReadCount = "already_read_count"
        case publisherFacet = "publisher_facet"
        case personKey = "person_key"
        case placeKey = "place_key"
        case timeFacet = "time_facet"
        case personFacet = "person_facet"
        case subjectFacet = "subject_facet"
        case version = "_version_"
        case placeFacet = "place_facet"
        case lccSort = "lcc_sort"
        case authorFacet = "author_facet"
        case subjectKey = "subject_key"
        case timeKey = "time_key"
        case ddcSort = "ddc_sort"
        case idNla = "id_nla"
        case idAmazonCoUkAsin = "id_amazon_co_uk_asin"
        case idAmazonCAAsin = "id_amazon_ca_asin"
        case idAmazonDeAsin = "id_amazon_de_asin"
        case idBetterWorldBooks = "id_better_world_books"
        case idBritishNationalBibliography = "id_british_national_bibliography"
        case idAmazonItAsin = "id_amazon_it_asin"
        case idBcid = "id_bcid"
        case idScribd = "id_scribd"
        case idHathiTrust = "id_hathi_trust"
        case idBritishLibrary = "id_british_library"
        case idBibliothèqueNationaleDeFrance = "id_bibliothèque_nationale_de_france"
        case idLibris = "id_libris"
        case idDnb = "id_dnb"
        case subtitle
    }
}
