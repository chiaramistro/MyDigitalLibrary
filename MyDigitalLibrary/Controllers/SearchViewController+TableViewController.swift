//
//  SearchViewController+TableViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 04/04/24.
//

import UIKit
import CoreData

extension SearchViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView numberOfRowsInSection: \(searchResults.count)")
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = searchResults[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)

        // Configure cell
        cell.textLabel?.text = result.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
            switch (self.type as! SearchEnum) {
            case SearchEnum.book:
                print("Add book to favourites")
                self.alertAuthor { includeAuthor in
                    self.addBook(includeAuthor: includeAuthor, indexPath: indexPath)
                }
            case SearchEnum.author:
                print("Add author to favourites")
                let selectedResult = self.searchResults[(indexPath as NSIndexPath).row]
                let author = Author(context: self.dataController.viewContext)
                author.key = selectedResult.descriptionKey
                author.photoKey = selectedResult.imageKey
                author.name = selectedResult.title
                try? self.dataController.viewContext.save()
                self.showToast(message: "New author saved successfully")
                debugPrint("New author saved successfully")
            default:
                debugPrint("Unknown type")
            }
        }
        
        favorite.backgroundColor = .red

        return [favorite]
    }
    
    func alertAuthor(completion: @escaping (Bool) -> Void) {
        //If we want to print something on the screen, we use UIAlertController:
        let alert = UIAlertController(title: "Excellent!", message: "Do you want to add the author of this book to favourites?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alertToCancel) in
            completion(false)
        }))

        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            completion(true)
        }))
        
        self.present(alert, animated: true)
    }
    
    func addBook(includeAuthor: Bool, indexPath: IndexPath) {
        let selectedResult = self.searchResults[(indexPath as NSIndexPath).row]
        let book = Book(context: self.dataController.viewContext)
        book.key = selectedResult.descriptionKey
        book.coverKey = selectedResult.imageKey
        book.title = selectedResult.title
        book.author = selectedResult.bookAuthorName
        if (includeAuthor) {
            let authorFound = self.checkForAuthor(authorKey: selectedResult.bookAuthorKey ?? "")
            if let authorFound = authorFound {
                book.authorData = authorFound
            } else {
                let author = Author(context: self.dataController.viewContext)
                author.key = selectedResult.bookAuthorKey
                author.photoKey = selectedResult.bookAuthorKey
                author.name = selectedResult.bookAuthorName
                book.authorData = author
            }
        }
        try? self.dataController.viewContext.save()
        self.showToast(message: "New book saved successfully")
        debugPrint("New book saved successfully")
    }
    
    func checkForAuthor(authorKey: String) -> Author? {
        let fetchRequest: NSFetchRequest<Author> = Author.fetchRequest()
        let predicate = NSPredicate(format: "key == %@", authorKey)
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "key", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = 1
        
        do {
            let result: [Author] = try self.dataController.viewContext.fetch(fetchRequest)
            if (result.isEmpty) { // no matching object
                print("Author is NOT already present")
                return nil
            } else { // at least one matching object exists
                print("Author is already present")
                return result.first
            }
        } catch let error as NSError {
            debugPrint("Could not fetch favourite author \(error.localizedDescription)")
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableView didSelectRowAt() \(indexPath)")
//         FIMXE instead of click, we swipe to add entry to favourites
        
//        let detailsController = self.storyboard!.instantiateViewController(withIdentifier: "LibraryDetailsViewController") as! LibraryDetailsViewController
//        let searchItem = searchResults[(indexPath as NSIndexPath).row]
//        detailsController.key = searchItem.key
//        detailsController.imageId = searchItem.imageId
//        detailsController.titleText = searchItem.title
//        detailsController.type = type
//        self.navigationController?.pushViewController(detailsController, animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
    }

}
