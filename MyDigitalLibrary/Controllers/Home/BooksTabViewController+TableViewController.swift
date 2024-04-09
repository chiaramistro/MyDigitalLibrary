//
//  BooksTabViewController+TableViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit
import CoreData

extension BooksTabViewController {
    
    // MARK: - Favourite books table view

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let book = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

        // Configure cell
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.author ?? "-"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookDetailsController = self.storyboard!.instantiateViewController(withIdentifier: "BookDetailsViewController") as! BookDetailsViewController
        let book = fetchedResultsController.object(at: indexPath)
        bookDetailsController.book = book
        bookDetailsController.onRemoveBook = { [weak self] in
            self?.deleteBook(itemToDelete: book)
            self?.navigationController?.popToRootViewController(animated: true)
        }
        bookDetailsController.onSaveImage = { [weak self] imageData in
            book.cover = imageData
            try? self?.dataController.viewContext.save()
            debugPrint("Book cover saved successfully")
        }
        bookDetailsController.onSaveTrama = { [weak self] trama in
            book.trama = trama
            try? self?.dataController.viewContext.save()
            debugPrint("Book trama saved successfully")
        }
        bookDetailsController.onSeeAuthor = canUserSeeBookAuthor(book: book)
        
        self.navigationController?.pushViewController(bookDetailsController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Table view actions methods
    
    func canUserSeeBookAuthor(book: Book) -> (() -> Void)? {
        let isAuthorFavourite = self.isAuthorFavourite(authorName: book.author ?? "")
        if let favouriteAuthor = isAuthorFavourite {
            debugPrint("Author is one of the favourites")
            if let authorData = book.authorData {
                debugPrint("Author data is defined for book")
            } else {
                debugPrint("Author data is NOT defined for book")
                book.authorData = favouriteAuthor
                try? self.dataController.viewContext.save()
            }
            return { [weak self] in
                self?.navigateToAuthor(book: book)
            }
        }
       
        debugPrint("Author is not one of the favourites, do NOT return function")
        return nil
    }
    
    func isAuthorFavourite(authorName: String) -> Author? {
        let fetchRequest: NSFetchRequest<Author> = Author.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", authorName)
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "key", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = 1
        
        do {
            let result: [Author] = try self.dataController.viewContext.fetch(fetchRequest)
            if (result.isEmpty) { // no matching object
                debugPrint("Author is NOT favourite")
                return nil
            } else { // at least one matching object exists
                debugPrint("Author is favourite")
                return result.first
            }
        } catch let error as NSError {
            debugPrint("Could not fetch favourite author \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteBook(itemToDelete: Book) {
        debugPrint("Remove book from favourites")
        dataController.viewContext.delete(itemToDelete)
        try? dataController.viewContext.save()
        self.showToast(message: "Book removed from favourites successfully")
        debugPrint("Book removed from favourites successfully")
    }
    
    func navigateToAuthor(book: Book) {
        let authorDetailsController = self.storyboard!.instantiateViewController(withIdentifier: "AuthorDetailsViewController") as! AuthorDetailsViewController
        authorDetailsController.author = book.authorData
        authorDetailsController.showFavourite = true
        authorDetailsController.onRemoveAuthor = { [weak self] in
            print("onRemoveAuthor()")
            self?.deleteAuthor(itemToDelete: book.authorData!)
            self?.navigationController?.popToRootViewController(animated: true)
        }
        authorDetailsController.onSavePhoto = { [weak self] imageData in
            book.authorData?.photo = imageData
            try? self?.dataController.viewContext.save()
            debugPrint("Author photo saved successfully")
        }
        authorDetailsController.onSaveBio = { [weak self] bio in
            book.authorData?.bio = bio
            try? self?.dataController.viewContext.save()
            debugPrint("Author bio saved successfully")
        }
        self.navigationController?.pushViewController(authorDetailsController, animated: true)
    }

    func deleteAuthor(itemToDelete: Author) {
        debugPrint("Remove author from favourites")
        dataController.viewContext.delete(itemToDelete)
        try? dataController.viewContext.save()
        self.showToast(message: "Author removed from favourites successfully")
        debugPrint("Author removed from favourites successfully")
    }
}
