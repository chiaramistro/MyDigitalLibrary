//
//  BooksTabViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit

class BooksTabViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var books: [LibraryDetails] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("BooksTabViewController viewDidLoad()")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addBook))
        navigationItem.title = "My Digital Library"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
    }
    
    func setLoading(isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        navigationItem.rightBarButtonItem?.isEnabled = !isLoading
    }
    
    @objc func addBook() {
        print("addBook()")
        let searchController = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchController.type = SearchEnum.book
       self.navigationController?.pushViewController(searchController, animated: true)
    }


}

