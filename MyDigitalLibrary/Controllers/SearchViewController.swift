//
//  SearchViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var type: SearchEnum!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    // FIXME save more complex search results?
    var searchResults: [LibraryDetails] = []
    
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
