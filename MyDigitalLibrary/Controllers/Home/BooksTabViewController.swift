//
//  BooksTabViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit
import CoreData

class BooksTabViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyBooksLabel: UILabel!
    
    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController<Book>!
    
    override func viewDidLoad() {
        emptyBooksLabel.isHidden = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addBook))
        navigationItem.title = "My Digital Library"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupFetchedResultsController()
        checkEmptyState()
    }
    
    func checkEmptyState() {
        if (fetchedResultsController.fetchedObjects?.count == 0) {
            emptyBooksLabel.isHidden = false
        } else {
            emptyBooksLabel.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupFetchedResultsController()
        checkEmptyState()
        tableView.reloadData()
    }
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "key", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "books")
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch of books could not be performed: \(error.localizedDescription)")
            self.showErrorAlert(message: "An error occurred retrieving your favourite books, try again later")
        }
    }
    
    @objc func addBook() {
        let searchController = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchController.type = SearchEnum.book
        searchController.dataController = dataController
       self.navigationController?.pushViewController(searchController, animated: true)
    }


}

