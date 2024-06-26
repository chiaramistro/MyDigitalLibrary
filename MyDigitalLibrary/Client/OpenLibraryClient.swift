//
//  OpenLibraryClient.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import Foundation

class OpenLibraryClient {
 
    // MARK: - Client endpoints
    
    enum Endpoints {
        static let base = "https://openlibrary.org"
        static let emptyImageBytes = 43

        case searchBook(String)
        case searchAuthor(String)
        case cover(String, SearchEnum)
        case works(String)
        case authorDetails(String)
        
        var stringValue: String {
            switch self {
                case .searchBook(let title): return Endpoints.base + "/search.json" + "?q=\(title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
                case .searchAuthor(let name): return Endpoints.base + "/search/authors.json" + "?q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
                case .cover(let id, let type): return "https://covers.openlibrary.org/\(type.rawValue)/olid/\(id)-M.jpg"
                case .works(let workId): return Endpoints.base + "\(workId).json"
                case .authorDetails(let authorId): return Endpoints.base + "/authors/\(authorId).json"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    // MARK: - GET author details request
    
    class func getAuthorDetails(authorId: String, completion: @escaping (AuthorResponse?, Error?) -> Void) -> URLSessionDataTask  {
        let task = taskForGETRequest(url: Endpoints.authorDetails(authorId).url, responseType: AuthorResponse.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
        return task
    }
        
    // MARK: - GET book details request
    
    class func getWorkInfo(workId: String, completion: @escaping (WorkResponse?, Error?) -> Void) -> URLSessionDataTask  {
        let task = taskForGETRequest(url: Endpoints.works(workId).url, responseType: WorkResponse.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
        return task
    }
    
    // MARK: - GET book cover or author photo request
        
    class func getCoverImage(id: String, type: SearchEnum, completion: @escaping (Data?, Error?) -> Void) {
        debugPrint("Get image URL: \(Endpoints.cover(id, type).url)")
        let download = URLSession.shared.dataTask(with: Endpoints.cover(id, type).url) { data, response, error in
             if let data = data {
                 if data.count > Endpoints.emptyImageBytes {
                     DispatchQueue.main.async {
                         completion(data, nil)
                     }
                 } else {
                     DispatchQueue.main.async {
                         completion(nil, AppError.runtimeError("Empty data return by website"))
                     }
                 }
             } else {
                 DispatchQueue.main.async {
                    completion(nil, error)
                 }
             }
         }
         download.resume()
     }
    
    // MARK: - GET search for a book
    
    class func searchBook(bookTitle: String, completion: @escaping ([BookResponse], Error?) -> Void) -> URLSessionDataTask  {
        let task = taskForGETRequest(url: Endpoints.searchBook(bookTitle).url, responseType: BookSearchResponse.self) { response, error in
            if let response = response {
                completion(response.docs, nil)
            } else {
                completion([], error)
            }
        }
        return task
    }
    
    // MARK: - GET search for an author
    
    class func searchAuthor(authorName: String, completion: @escaping ([AuthorBookResponse], Error?) -> Void) -> URLSessionDataTask  {
        let task = taskForGETRequest(url: Endpoints.searchAuthor(authorName).url, responseType: AuthorSearchResponse.self) { response, error in
            if let response = response {
                completion(response.docs, nil)
            } else {
                completion([], error)
            }
        }
        return task
    }
    
    // MARK: - Generic GET request method

    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        debugPrint("Request URL \(url)")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                debugPrint("Data not valid")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(responseType, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch {
                debugPrint("Parsing not valid")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }

        task.resume()
        return task
    }
    
}

// MARK: - Generic App error

enum AppError: Error {
    case runtimeError(String)
}
