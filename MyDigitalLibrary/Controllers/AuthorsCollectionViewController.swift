//
//  AuthorsCollectionViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit

class AuthorsCollectionViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("AuthorsCollectionViewController viewDidLoad()")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAuthor))
        navigationItem.title = "My Digital Library"
        
    }
    
    @objc func addAuthor() {
        print("addAuthor()")
        let searchController = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchController.type = SearchEnum.author
       self.navigationController?.pushViewController(searchController, animated: true)
    }


}
