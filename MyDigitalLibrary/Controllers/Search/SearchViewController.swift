//
//  SearchViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit
import CoreData

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var type: SearchEnum!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var searchResults: [SearchResult] = []
    
    @IBOutlet weak var emptyResultsLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var currentSearchTask: URLSessionDataTask?
    
    var dataController: DataController!
    
    override func viewDidLoad() {
        print("SearchViewController viewDidLoad()")
        print("SearchViewController viewDidLoad() type \(type)")
        
        emptyResultsLabel.isHidden = true
        
        navigationItem.title = "Search"
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setLoading(isLoading: Bool) {
        print("setLoading(\(isLoading))")
        emptyResultsLabel.isHidden = true
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
}
