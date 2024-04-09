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
        self.searchResults = [] // reset
        
        if (searchText.isEmpty) {
            debugPrint("No search text")
            searchBar.endEditing(true)
            setLoading(isLoading: false)
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
            print("searchAuthor() returned")
            if let error = error {
                if (error.localizedDescription.contains("cancelled")) {
                    debugPrint("Author search terminated by user")
                    return
                }
                debugPrint("Error in searchAuthor() \(error.localizedDescription)")
                self.setLoading(isLoading: false)
                self.showErrorAlert(message: "Some error occurred while searching for authors, please try again")
                return
            }
            
            if (result.isEmpty) {
                self.reloadSearchResults()
                self.emptyResultsLabel.isHidden = false
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
            print("searchBook() returned")
            if let error = error {
                if (error.localizedDescription.contains("cancelled")) {
                    debugPrint("Book search terminated by user")
                    return
                }
                debugPrint("Error in searchBook() \(error.localizedDescription)")
                self.setLoading(isLoading: false)
                self.showErrorAlert(message: "Some error occurred while searching for books, please try again")
                return
            }
            
            if (result.isEmpty) {
                self.reloadSearchResults()
                self.emptyResultsLabel.isHidden = false
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
