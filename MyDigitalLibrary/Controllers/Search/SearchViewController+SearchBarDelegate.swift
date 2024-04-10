//
//  SearchViewController+SearchBarDelegate.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 04/04/24.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    // MARK: - Search bar methods
    
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
        currentSearchTask = OpenLibraryClient.searchAuthor(authorName: searchText) { result, error in
            if let error = error {
                self.displayEmptyState()
                self.handleSearchError(error: error, errorMessage: "Some error occurred while searching for authors, please try again")
                return
            }
            
            if (result.isEmpty) {
                self.displayEmptyState()
                return
            }
            
            for author in result {
                self.searchResults.append(SearchResult(title: author.name, description: author.name, imageKey: author.key, descriptionKey: author.key, bookAuthorKey: nil, bookAuthorName: nil))
            }
            
            self.reloadSearchResults()
        }
    }
    
    func searchBooks(searchText: String) {
        currentSearchTask = OpenLibraryClient.searchBook(bookTitle: searchText) { result, error in
            if let error = error {
                self.displayEmptyState()
                self.handleSearchError(error: error, errorMessage: "Some error occurred while searching for books, please try again")
                return
            }
            
            if (result.isEmpty) {
                self.displayEmptyState()
                return
            }
            
            for book in result {
                self.searchResults.append(SearchResult(title: book.title, description: book.title, imageKey: (book.coverEditionKey ?? book.editionKey?[0]) ?? "", descriptionKey: book.key, bookAuthorKey: book.authorKey?[0] ?? nil, bookAuthorName: book.authorName?[0] ?? nil))
            }
            
            self.reloadSearchResults()
        }
    }
    
    func displayEmptyState() {
        self.reloadSearchResults()
        self.emptyResultsLabel.isHidden = false
    }
    
    func handleSearchError(error: Error, errorMessage: String) {
        if (error.localizedDescription.contains("cancelled")) {
            debugPrint("Search terminated by user")
            return
        }
        self.setLoading(isLoading: false)
        debugPrint(errorMessage)
        self.showErrorAlert(message: errorMessage)
    }
    
    func reloadSearchResults() {
        self.setLoading(isLoading: false)
        self.tableView.reloadData()
    }
    
}
