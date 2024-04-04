//
//  LibraryDetailsViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 03/04/24.
//

import UIKit

class LibraryDetailsViewController: UIViewController {
    
    var imageId: String!
    var key: String!
    var titleText: String!
    var descriptionText: String!
    var type: SearchEnum!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addBookToFavoritesButton: UIButton!
    
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var descriptionActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        print("LibraryDetailsViewController viewDidLoad()")
        
        navigationItem.title = titleText
        descriptionLabel.text = "..."
        descriptionActivityIndicator.startAnimating()
        
        if (type == SearchEnum.author) {
            addBookToFavoritesButton.isHidden = true
            OpenLibraryClient.getAuthorDetails(authorId: key) { result, error in
                if let result = result {
                    print("getAuthorDetails() success \(result)")
                    self.descriptionActivityIndicator.stopAnimating()
                    self.descriptionLabel.text = result.bio ?? "No description available"
                } else {
                    print("getAuthorDetails() error \(error?.localizedDescription)")
                    self.descriptionActivityIndicator.stopAnimating()
                    self.descriptionLabel.text = "No description available"
                }
            }
        } else if (type == SearchEnum.book) {
            OpenLibraryClient.getWorkInfo(workId: key) { result, error in
                if let result = result {
                    print("getWorkInfo() success \(result)")
                    self.descriptionActivityIndicator.stopAnimating()
                    self.descriptionLabel.text = result.description?.value ?? "No description available"
                } else {
                    print("getWorkInfo() error \(error?.localizedDescription)")
                    self.descriptionActivityIndicator.stopAnimating()
                    self.descriptionLabel.text = "No description available"
                }
                
            }
        }
        
        imageActivityIndicator.startAnimating()
        imageView.image = UIImage(systemName: "pin") // FIXME add grey image placeholder
        OpenLibraryClient.getCoverImage(id: imageId, type: type) { image, error in
            if let image = image {
                print("getBookCoverImage() success \(image)")
                self.imageActivityIndicator.stopAnimating()
                self.imageView.image = UIImage(data: image)
            } else {
                print("getBookCoverImage() error \(error?.localizedDescription)")
                self.imageActivityIndicator.stopAnimating()
                self.imageView.image = UIImage(systemName: "pin") // FIXME add grey image placeholder
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
