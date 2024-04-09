//
//  AuthorsCollectionViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit
import CoreData

class AuthorsCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var emptyAuthorsLabel: UILabel!
    
    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController<Author>!
    
    override func viewDidLoad() {
        emptyAuthorsLabel.isHidden = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAuthor))
        navigationItem.title = "My Digital Library"
        
        collectionView.collectionViewLayout = createRowLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupFetchedResultsController()
        checkEmptyState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupFetchedResultsController()
        checkEmptyState()
        collectionView.reloadData()
    }
    
    func checkEmptyState() {
        if (fetchedResultsController.fetchedObjects?.count == 0) {
            emptyAuthorsLabel.isHidden = false
        } else {
            emptyAuthorsLabel.isHidden = true
        }
    }
    
    // MARK: - Fetched results controller
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Author> = Author.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "key", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "authors")
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch of authors could not be performed: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Add author navigation
    
    @objc func addAuthor() {
        let searchController = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchController.type = SearchEnum.author
        searchController.dataController = dataController
       self.navigationController?.pushViewController(searchController, animated: true)
    }


}
