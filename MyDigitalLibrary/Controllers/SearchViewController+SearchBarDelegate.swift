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
        
        // FIXME loading not shown
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
            if (result.isEmpty) {
                // FIXME show empty state
                return
            }
            
            for author in result {
                self.searchResults.append(LibraryDetails(imageId: author.key, key: author.key, title: author.name, description: author.name))
            }
            
            DispatchQueue.main.async {
                self.setLoading(isLoading: false)
                print("reloading data start...")
                self.tableView.reloadData()
                print("reloading data end...")
            }
        }
    }
    
    func searchBooks(searchText: String) {
        print("searchBook()")
        currentSearchTask = OpenLibraryClient.searchBook(bookTitle: searchText) { result, error in
            //print("searchBook() result: \(result)")
            print("searchBook() success")
            if (result.isEmpty) {
                // FIXME show empty state
                return
            }
            
            for book in result {
                self.searchResults.append(LibraryDetails(imageId: (book.coverEditionKey ?? book.editionKey?[0]) ?? "", key: book.key, title: book.title, description: book.title))
            }
            
            DispatchQueue.main.async {
                self.setLoading(isLoading: false)
                print("reloading data start...")
                self.tableView.reloadData()
                print("reloading data end...")
            }
        }
    }
    
}
