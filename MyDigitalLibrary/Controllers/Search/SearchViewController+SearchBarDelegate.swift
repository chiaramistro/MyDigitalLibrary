//
//  SearchViewController+SearchBarDelegate.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 04/04/24.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentSearchTask?.cancel()
        if (searchText.isEmpty) {
            debugPrint("No search text")
            searchBar.endEditing(true)
            searchResults = []
            tableView.reloadData()
            return
        }
        
        setLoading(isLoading: true)
        switch type {
        case .book:
            searchBooks(searchText: searchText)
        case .author:
            searchAuthors(searchText: searchText)
        default:
            debugPrint("No valid search type")
        }
    }
    
    func searchAuthors(searchText: String) {
        print("searchAuthors()")
        currentSearchTask = OpenLibraryClient.searchAuthor(authorName: searchText) { result, error in
            print("searchAuthor() success")
            // FIXME error handling
            
            if (result.isEmpty) {
                // FIXME show empty state
                return
            }
            
            for author in result {
                self.searchResults.append(SearchResult(title: author.name, description: author.name, imageKey: author.key, descriptionKey: author.key, bookAuthorKey: nil, bookAuthorName: nil))
            }
            
            self.reloadSearchResults()
        }
    }
    
    func searchBooks(searchText: String) {
        print("searchBook()")
        currentSearchTask = OpenLibraryClient.searchBook(bookTitle: searchText) { result, error in
            // FIXME error handling
            
            print("searchBook() success")
            if (result.isEmpty) {
                // FIXME show empty state
                return
            }
            
            for book in result {
                self.searchResults.append(SearchResult(title: book.title, description: book.title, imageKey: (book.coverEditionKey ?? book.editionKey?[0]) ?? "", descriptionKey: book.key, bookAuthorKey: book.authorKey?[0] ?? nil, bookAuthorName: book.authorName?[0] ?? nil))
            }
            
            self.reloadSearchResults()
        }
    }
    
    func reloadSearchResults() {
        self.setLoading(isLoading: false)
        self.tableView.reloadData()
    }
    
}
