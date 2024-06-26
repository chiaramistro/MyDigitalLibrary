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
        navigationItem.title = author.name
        
        if (showFavourite) {
            let heartImage = isFavorite ? selectedImage : deselectedImage
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(toggleAuthorFavorite))
        }

        bioActivityIndicator.startAnimating()

        // FIXME description does not fill space + does not scroll
        getAuthorBio()
        getAuthorPhoto()
    }
    
    // MARK: - Author details fetching
    
    func getAuthorBio() {
        if let authorBio = author.bio {
            debugPrint("Author DOES have bio")
            bioActivityIndicator.stopAnimating()
            authorBioLabel.text = authorBio
        } else {
            debugPrint("Author DOES NOT have bio")
            OpenLibraryClient.getAuthorDetails(authorId: author.key ?? "") { result, error in
                if let error = error {
                    debugPrint("Error getting author details: \(error.localizedDescription)")
                    self.handleAuthorBioError()
                    return
                }
                
                if let result = result {
                    self.bioActivityIndicator.stopAnimating()
                    self.authorBioLabel.text = result.displayBio()
                    self.onSaveBio?(result.displayBio())
                } else {
                    debugPrint("Error getting author details: \(String(describing: error?.localizedDescription))")
                    self.handleAuthorBioError()
                }
            }
        }
    }
    
    func handleAuthorBioError() {
        self.bioActivityIndicator.stopAnimating()
        self.authorBioLabel.text = "No description available"
        self.showErrorAlert(message: "An error occurred retrieving the author's biography, try again later")
    }
    
    func getAuthorPhoto() {
        imageView.image =  UIImage(named: "image-placeholder")
        if let authorPhoto = author.photo {
            debugPrint("Author DOES have photo")
            imageView.image = UIImage(data: authorPhoto)
        } else {
            debugPrint("Author DOES NOT have photo")
            OpenLibraryClient.getCoverImage(id: author.photoKey ?? "", type: SearchEnum.author) { image, error in
                if let error = error {
                    debugPrint("Error getting author photo: \(error.localizedDescription)")
                    self.handleAuthorPhotoError()
                    return
                }
                
                if let image = image {
                    self.imageView.image = UIImage(data: image)
                    self.onSavePhoto?(image)
                } else {
                    debugPrint("Error getting author photo: \(String(describing: error?.localizedDescription))")
                    self.handleAuthorPhotoError()
                }
            }
    
        }
    }
    
    func handleAuthorPhotoError() {
        self.imageView.image =  UIImage(named: "image-placeholder")
        self.showErrorAlert(message: "An error occurred retrieving the author's photo, try again later")
    }
    
    // MARK: - Author details actions
    
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
        isFavorite = !isFavorite
        toggleHeartButton(navigationItem.rightBarButtonItem, enabled: isFavorite)
        onRemoveAuthor?()
    }
    
}
