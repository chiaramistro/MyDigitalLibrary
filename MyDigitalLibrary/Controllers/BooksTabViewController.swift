//
//  BooksTabViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit

class BooksTabViewController: UIViewController, UITableViewDataSource {
    
    var books: [Book] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("BooksTabViewController viewDidLoad()")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addBook))
        navigationItem.title = "My Digital Library"
        
        self.tableView.dataSource = self
        
        setLoading(isLoading: true)
        OpenLibraryClient.searchBook(bookTitle: "lord+of+the+rings") { result, error in
            //print("searchBook() result: \(result)")
            print("searchBook() success")
            self.books = result
            DispatchQueue.main.async {
                self.setLoading(isLoading: false)
                print("reloading data start...")
                self.tableView.reloadData()
                print("reloading data end...")
            }
        }
        
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

