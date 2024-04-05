//
//  BookDetailsViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 05/04/24.
//

import UIKit
import CoreData

class BookDetailsViewController: UIViewController, NSFetchedResultsControllerDelegate {

    var book: Book!
    var isFavorite: Bool = true
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionActivityIndicator: UIActivityIndicatorView!

    var dataController: DataController!

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
        
        getBookCover()
    }
    
    func getBookCover() {
        imageView.image = UIImage(systemName: "pin") // FIXME add grey image placeholder
        if let bookCover = book.cover {
            self.imageView.image = UIImage(data: book.cover ?? Data())
        } else {
//            OpenLibraryClient.getCoverImage(id: book.key, type: type) { image, error in
//                if let image = image {
//                    print("getBookCoverImage() success \(image)")
//                    self.imageView.image = UIImage(data: image)
//                } else {
//                    print("getBookCoverImage() error \(error?.localizedDescription)")
                    self.imageView.image = UIImage(systemName: "pin") // FIXME add grey image placeholder
//                }
//
//            }
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
//        if (isFavorite) {
//            print("Add book to favourites")
//            let book = Book(context: dataController.viewContext)
//            book.key = book.key
//            book.title = titleText
//            book.trama = descriptionLabel.text
//            book.cover = imageView.image?.pngData()
//            // FIXME add author data too
//    //        let author = Author(context: dataController.viewContext)
//    //        author.key = ""
//    //        author.name = ""
//    //        author.bio = ""
//    //        book.author = author
//            try? dataController.viewContext.save()
//            debugPrint("New book saved successfully")
//            navigationController?.popToRootViewController(animated: true)
//        } else {
//            print("Remove book from favourites")
//        }
    }
    
}
