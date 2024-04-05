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
    var showFavourite: Bool = true
    var isFavorite: Bool = true
    var onRemoveAuthor: (() -> Void)?
    var onSavePhoto: ((_ image: Data) -> Void)?
    var onSaveBio: ((_ trama: String?) -> Void)?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var authorBioLabel: UILabel!
    @IBOutlet weak var bioActivityIndicator: UIActivityIndicatorView!
    
    var deselectedImage = UIImage(systemName: "heart")
    var selectedImage = UIImage(systemName: "heart.fill")

    override func viewDidLoad() {
        print("AuthorDetailsViewController viewDidLoad()")

        navigationItem.title = author.name
        
        if (showFavourite) {
            let heartImage = isFavorite ? selectedImage : deselectedImage
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(toggleAuthorFavorite))
        }

        bioActivityIndicator.startAnimating()

        // FIXME description does not fill space + does not scroll
        if let authorBio = author.bio {
            debugPrint("Author DOES have bio")
            bioActivityIndicator.stopAnimating()
            authorBioLabel.text = authorBio
        } else {
            debugPrint("Author DOES NOT have bio")
            OpenLibraryClient.getAuthorDetails(authorId: author.key ?? "") { result, error in
                    if let result = result {
                        print("getAuthorDetails() success \(result)")
                        self.bioActivityIndicator.stopAnimating()
                        self.authorBioLabel.text = result.bio ?? "No description available"
                        self.onSaveBio?(result.bio)
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
            debugPrint("Author DOES have photo")
            imageView.image = UIImage(data: authorPhoto)
        } else {
            debugPrint("Author DOES NOT have photo")
            OpenLibraryClient.getCoverImage(id: author.photoKey ?? "", type: SearchEnum.author) { image, error in
                print("getCoverImage() success")
                if let image = image {
                    print("getCoverImage() success \(image)")
                    self.imageView.image = UIImage(data: image)
                    self.onSavePhoto?(image)
                } else {
                    print("getCoverImage() error \(error?.localizedDescription)")
                    self.imageView.image = UIImage(systemName: "pin") // FIXME add grey image placeholder
                }
            }
    
        }
    }
    

    func toggleHeartButton(_ button: UIBarButtonItem?, enabled: Bool) {
        if (showFavourite) {
            if enabled {
                navigationItem.rightBarButtonItem?.image = selectedImage
            } else {
                navigationItem.rightBarButtonItem?.image = deselectedImage
            }
        }
    }

    @objc func toggleAuthorFavorite() {
        print("toggleAuthorFavorite()")
        isFavorite = !isFavorite
        toggleHeartButton(navigationItem.rightBarButtonItem, enabled: isFavorite)
        onRemoveAuthor?()
    }
    
}
