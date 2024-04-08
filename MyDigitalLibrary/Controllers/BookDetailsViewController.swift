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
    var onSaveImage: ((_ image: Data) -> Void)?
    var onSaveTrama: ((_ trama: String?) -> Void)?
    var onSeeAuthor: (() -> Void)?
    
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
            debugPrint("Book DOES have trama")
            descriptionActivityIndicator.stopAnimating()
            descriptionLabel.text = bookTrama
        } else {
            debugPrint("Book DOES NOT have trama")
            OpenLibraryClient.getWorkInfo(workId: book.key ?? "") { result, error in
                if let result = result {
                    print("getWorkInfo() success")
                    self.descriptionActivityIndicator.stopAnimating()
                    self.descriptionLabel.text = result.description?.value ?? "No description available"
                    self.onSaveTrama?(result.description?.value)
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
        imageView.image = UIImage(named: "image-placeholder")
        if let bookCover = book.cover {
            debugPrint("Book DOES have cover")
            self.imageView.image = UIImage(data: bookCover)
        } else {
            debugPrint("Book DOES NOT have cover")
            OpenLibraryClient.getCoverImage(id: book.coverKey ?? "", type: SearchEnum.book) { image, error in
                print("getBookCover() success")
                if let image = image {
                    print("getBookCoverImage() success \(image)")
                    self.imageView.image = UIImage(data: image)
                    self.onSaveImage?(image)
                } else {
                    print("getBookCoverImage() error \(error?.localizedDescription)")
                    self.imageView.image = UIImage(named: "image-placeholder")
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
    
    @IBAction func onSeeAuthorTap(_ sender: Any) {
        print("onSeeAuthorTap()")
        onSeeAuthor?()
    }
    
    
}
