//
//  SearchResultViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 03/04/24.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var imageId: String!
    var key: String!
    var titleText: String!
    var descriptionText: String!
    var type: SearchEnum!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addBookToFavoritesButton: UIButton!
    
    override func viewDidLoad() {
        print("SearchResultViewController viewDidLoad()")
        
        navigationItem.title = titleText
        descriptionLabel.text = "..."
        
        if (type == SearchEnum.author) {
            addBookToFavoritesButton.isHidden = true
            OpenLibraryClient.getAuthorDetails(authorId: key) { result, error in
                if let result = result {
                    print("getAuthorDetails() success \(result)")
                    self.descriptionLabel.text = result.bio ?? "No description available"
                } else {
                    print("getAuthorDetails() error \(error?.localizedDescription)")
                    self.descriptionLabel.text = "..."
                }
            }
        } else if (type == SearchEnum.book) {
            OpenLibraryClient.getWorkInfo(workId: key) { result, error in
                if let result = result {
                    print("getWorkInfo() success \(result)")
                    self.descriptionLabel.text = result.description?.value ?? "No description available"
                } else {
                    print("getWorkInfo() error \(error?.localizedDescription)")
                    self.descriptionLabel.text = "..."
                }
                
            }
        }
        
         imageView.image = UIImage(systemName: "pin") // FIXME add image placeholder
        OpenLibraryClient.getBookCoverImage(id: imageId) { image, error in
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
