//
//  AuthorDetailsViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 05/04/24.
//

import UIKit
import CoreData

class AuthorDetailsViewController: UIViewController {
    
    var author: Author!
    var isFavorite: Bool = true
    var onRemoveAuthor: (() -> Void)?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var authorBioLabel: UILabel!
    @IBOutlet weak var bioActivityIndicator: UIActivityIndicatorView!
    
    var deselectedImage = UIImage(systemName: "heart")
    var selectedImage = UIImage(systemName: "heart.fill")

    override func viewDidLoad() {
        print("AuthorDetailsViewController viewDidLoad()")

        navigationItem.title = author.name
        let heartImage = isFavorite ? selectedImage : deselectedImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(toggleAuthorFavorite))

        bioActivityIndicator.startAnimating()

        // FIXME description does not fill space + does not scroll
        if let authorBio = author.bio {
            bioActivityIndicator.stopAnimating()
            authorBioLabel.text = authorBio
        } else {
            OpenLibraryClient.getAuthorDetails(authorId: author.key ?? "") { result, error in
                    if let result = result {
                        print("getAuthorDetails() success \(result)")
                        self.bioActivityIndicator.stopAnimating()
                        self.authorBioLabel.text = result.bio ?? "No description available"
                    } else {
                        print("getAuthorDetails() error \(error?.localizedDescription)")
                        self.bioActivityIndicator.stopAnimating()
                        self.authorBioLabel.text = "No description available"
                    }
                }
        }

        getAuthorPhoto()
    }
    
    func getAuthorPhoto() {
        imageView.image = UIImage(systemName: "pin") // FIXME add grey image placeholder
        if let authorPhoto = author.photo {
            imageView.image = UIImage(data: authorPhoto)
        } else {
            OpenLibraryClient.getCoverImage(id: author.photoKey ?? "", type: SearchEnum.author) { image, error in
                print("getCoverImage() success")
                if let image = image {
                    print("getCoverImage() success \(image)")
                    self.imageView.image = UIImage(data: image)
                } else {
                    print("getCoverImage() error \(error?.localizedDescription)")
                    self.imageView.image = UIImage(systemName: "pin") // FIXME add grey image placeholder
                }
            }
    
        }
    }
    

    func toggleHeartButton(_ button: UIBarButtonItem?, enabled: Bool) {
        if enabled {
            navigationItem.rightBarButtonItem?.image = selectedImage
        } else {
            navigationItem.rightBarButtonItem?.image = deselectedImage
        }
    }

    @objc func toggleAuthorFavorite() {
        print("toggleAuthorFavorite()")
        isFavorite = !isFavorite
        toggleHeartButton(navigationItem.rightBarButtonItem, enabled: isFavorite)
        onRemoveAuthor?()
    }
    
}
