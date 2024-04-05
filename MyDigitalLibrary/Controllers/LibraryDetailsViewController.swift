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
    var descriptionText: String = ""
    var type: SearchEnum!
    var isFavorite: Bool = false
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionActivityIndicator: UIActivityIndicatorView!
    
    var deselectedImage = UIImage(systemName: "heart")
    var selectedImage = UIImage(systemName: "heart.fill")
    
    override func viewDidLoad() {
        print("LibraryDetailsViewController viewDidLoad()")
        
        navigationItem.title = titleText
        let heartImage = isFavorite ? selectedImage : deselectedImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(toggleFavorite))
        
        descriptionActivityIndicator.startAnimating()
        
        // FIXME description does not fill space + does not scroll
        if (descriptionText.count > 0) {
            descriptionActivityIndicator.stopAnimating()
            descriptionLabel.text = descriptionText
        } else {
            if (type == SearchEnum.author) {
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
        }
        
        imageView.image = UIImage(systemName: "pin") // FIXME add grey image placeholder
        OpenLibraryClient.getCoverImage(id: imageId, type: type) { image, error in
            if let image = image {
                print("getBookCoverImage() success \(image)")
                self.imageView.image = UIImage(data: image)
            } else {
                print("getBookCoverImage() error \(error?.localizedDescription)")
                self.imageView.image = UIImage(systemName: "pin") // FIXME add grey image placeholder
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
    
    @objc func toggleFavorite() {
        switch type {
        case .book:
            toggleBookFavorites()
        case .author:
            toggleAuthorFavorites()
        default:
            debugPrint("No valid type")
        }
    }
    
    func toggleBookFavorites() {
        print("toggleBookFavorites()")
        isFavorite = !isFavorite
        toggleHeartButton(navigationItem.rightBarButtonItem, enabled: isFavorite)
    }
    
    func toggleAuthorFavorites() {
        print("toggleAuthorFavorites()")
        isFavorite = !isFavorite
        toggleHeartButton(navigationItem.rightBarButtonItem, enabled: isFavorite)
    }
    
    
}
