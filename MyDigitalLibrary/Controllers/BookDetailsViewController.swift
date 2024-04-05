//
//  BookDetailsViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 05/04/24.
//

import UIKit
import CoreData

class BookDetailsViewController: UIViewController {

    var book: Book!
    var isFavorite: Bool = true
    var onRemoveBook: (() -> Void)?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionActivityIndicator: UIActivityIndicatorView!
    
    var deselectedImage = UIImage(systemName: "heart")
    var selectedImage = UIImage(systemName: "heart.fill")
    
    override func viewDidLoad() {
        print("BookDetailsViewController viewDidLoad()")
        
        navigationItem.title = book.title
        let heartImage = isFavorite ? selectedImage : deselectedImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(toggleBookFavorites))
        
        descriptionActivityIndicator.startAnimating()
        
        // FIXME description does not fill space + does not scroll
        if let bookTrama = book.trama {
            descriptionActivityIndicator.stopAnimating()
            descriptionLabel.text = bookTrama
        } else {
            OpenLibraryClient.getWorkInfo(workId: book.key ?? "") { result, error in
                if let result = result {
                    print("getWorkInfo() success")
                    self.descriptionActivityIndicator.stopAnimating()
                    self.descriptionLabel.text = result.description?.value ?? "No description available"
                } else {
                    print("getWorkInfo() error \(error?.localizedDescription)")
                    self.descriptionActivityIndicator.stopAnimating()
                    self.descriptionLabel.text = "No description available"
                }
                
            }
        }
        
        getBookCover()
    }
    
    func getBookCover() {
        imageView.image = UIImage(systemName: "pin") // FIXME add grey image placeholder
        if let bookCover = book.cover {
            self.imageView.image = UIImage(data: bookCover)
        } else {
            OpenLibraryClient.getCoverImage(id: book.coverKey ?? "", type: SearchEnum.book) { image, error in
                print("getBookCover() success")
                if let image = image {
                    print("getBookCoverImage() success \(image)")
                    self.imageView.image = UIImage(data: image)
                } else {
                    print("getBookCoverImage() error \(error?.localizedDescription)")
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
    
    @objc func toggleBookFavorites() {
        print("toggleBookFavorites()")
        isFavorite = !isFavorite
        toggleHeartButton(navigationItem.rightBarButtonItem, enabled: isFavorite)
        onRemoveBook?()
    }
    
}
