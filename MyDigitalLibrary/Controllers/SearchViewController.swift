//
//  SearchViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit

//class SearchResult {
//    var title: String
//    var desc: String
//}

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var type: SearchEnum!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    // FIXME save more complex search results?
    var searchResults: [String] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    var currentSearchTask: URLSessionDataTask?
    
    override func viewDidLoad() {
        print("SearchViewController viewDidLoad()")
        print("SearchViewController viewDidLoad() type \(type)")
        
        navigationItem.title = "Search"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func setLoading(isLoading: Bool) {
        print("setLoading(\(isLoading))")
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

extension SearchViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView numberOfRowsInSection: \(searchResults.count)")
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView cellForRowAt \(indexPath)")
        
        let result = searchResults[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)

        // Configure cell
        cell.textLabel?.text = result
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableView didSelectRowAt() \(indexPath)")
        let searchResultController = self.storyboard!.instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
        searchResultController.result = searchResults[(indexPath as NSIndexPath).row]
        self.navigationController?.pushViewController(searchResultController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

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
            
            for entry in result {
                self.searchResults.append(entry.name)
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
            
            for entry in result {
                self.searchResults.append(entry.title)
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
