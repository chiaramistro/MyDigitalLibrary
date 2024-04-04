//
//  SearchResultViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 03/04/24.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var id: String!
    var titleText: String!
    var descriptionText: String!
    var type: SearchEnum!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addBookToFavoritesButton: UIButton!
    
    override func viewDidLoad() {
        print("SearchResultViewController viewDidLoad()")
        
        navigationItem.title = titleText
        descriptionLabel.text = descriptionText
        
        if (type == SearchEnum.author) {
            addBookToFavoritesButton.isHidden = true
        }
        
         imageView.image = UIImage(systemName: "pin") // FIXME add image placeholder
        OpenLibraryClient.getBookCoverImage(id: id) { image, error in
            if let image = image {
                print("getBookCoverImage() success \(image)")
                self.imageView.image = UIImage(data: image)
            } else {
                print("getBookCoverImage() error \(error?.localizedDescription)")
                self.imageView.image = UIImage(systemName: "home")
            }
            
        }
    }
    
    @IBAction func onAddBookToFavorites(_ sender: Any) {
        print("onAddBookToFavorites()")
    }
    
    
    @IBAction func onAddAuthorToFavorites(_ sender: Any) {
        print("onAddAuthorToFavorites()")
    }
    
}
