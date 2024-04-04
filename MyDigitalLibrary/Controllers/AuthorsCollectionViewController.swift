//
//  AuthorsCollectionViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit

class AuthorsCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var authors: [LibraryDetails] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("AuthorsCollectionViewController viewDidLoad()")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAuthor))
        navigationItem.title = "My Digital Library"
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc func addAuthor() {
        print("addAuthor()")
        let searchController = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchController.type = SearchEnum.author
       self.navigationController?.pushViewController(searchController, animated: true)
    }


}
