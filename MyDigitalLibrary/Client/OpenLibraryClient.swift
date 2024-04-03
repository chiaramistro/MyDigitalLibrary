//
//  OpenLibraryClient.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import Foundation

class OpenLibraryClient {
 
    enum Endpoints {
        static let base = "https://openlibrary.org/"
        
        case searchBook(String)
        case searchAuthor(String)
        case bookCover(String)
        
        var stringValue: String {
            switch self {
                case .searchBook(let title): return Endpoints.base + "search.json" + "?q=\(title)"
                case .searchAuthor(let name): return Endpoints.base + "search/authors.json" + "?q=\(name)"
                case .bookCover(let id): return "https://covers.openlibrary.org/b/isbn/\(id)-M.jpg"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }

    }
    
    class func getBookCoverImage(id: String, completion: @escaping (Data?, Error?) -> Void) {
        let download = URLSession.shared.dataTask(with: Endpoints.bookCover(id).url) { data, response, error in
             if let data = data {
                 DispatchQueue.main.async {
                     completion(data, nil)
                 }
             } else {
                 DispatchQueue.main.async {
                    completion(nil, error)
                 }
             }
         }
         download.resume()
     }
    
    class func searchBook(bookTitle: String, completion: @escaping ([BookResponse], Error?) -> Void) -> URLSessionDataTask  {
        let query = bookTitle.lowercased().replacingOccurrences(of: " ", with: "+")
        let task = taskForGETRequest(url: Endpoints.searchBook(query).url, responseType: BookSearchResponse.self) { response, error in
            if let response = response {
                completion(response.docs, nil)
            } else {
                completion([], error)
            }
        }
        return task
    }
    
    class func searchAuthor(authorName: String, completion: @escaping ([AuthorBookResponse], Error?) -> Void) -> URLSessionDataTask  {
        let query = authorName.lowercased().replacingOccurrences(of: " ", with: "+")
        let task = taskForGETRequest(url: Endpoints.searchAuthor(query).url, responseType: AuthorSearchResponse.self) { response, error in
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
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Data not valid")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            //let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            //print(json)
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(responseType, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch {
                print("Parsing not valid")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }

        task.resume()
        return task
    }
}
