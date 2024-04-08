//
//  BooksTabViewController+TableViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit

extension BooksTabViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView cellForRowAt \(indexPath)")
        
        let book = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

        // Configure cell
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.author?.name ?? "-"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookDetailsController = self.storyboard!.instantiateViewController(withIdentifier: "BookDetailsViewController") as! BookDetailsViewController
        let book = fetchedResultsController.object(at: indexPath)
        bookDetailsController.book = book
        bookDetailsController.onRemoveBook = { [weak self] in
            print("onRemoveBook()")
            self?.deleteBook(itemToDelete: book)
            self?.navigationController?.popViewController(animated: true)
        }
        bookDetailsController.onSaveImage = { [weak self] imageData in
            print("onSaveImage()")
            book.cover = imageData
            try? self?.dataController.viewContext.save()
            debugPrint("Book cover saved successfully")
        }
        bookDetailsController.onSaveTrama = { [weak self] trama in
            print("onSaveTrama()")
            book.trama = trama
            try? self?.dataController.viewContext.save()
            debugPrint("Book trama saved successfully")
        }
        bookDetailsController.onSeeAuthor = { [weak self] in
            print("onSeeAuthor()")
            self?.navigateToAuthor(book: book)
        }
        
        self.navigationController?.pushViewController(bookDetailsController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func deleteBook(itemToDelete: Book) {
        print("Remove book from favourites")
        dataController.viewContext.delete(itemToDelete)
        try? dataController.viewContext.save()
        self.showToast(message: "Book removed from favourites successfully")
        debugPrint("Book removed from favourites successfully")
    }
    
    func navigateToAuthor(book: Book) {
        let authorDetailsController = self.storyboard!.instantiateViewController(withIdentifier: "AuthorDetailsViewController") as! AuthorDetailsViewController
        authorDetailsController.author = book.author
        authorDetailsController.showFavourite = true
        authorDetailsController.onRemoveAuthor = { [weak self] in
            print("onRemoveAuthor()")
            self?.deleteAuthor(itemToDelete: book.author!)
            self?.navigationController?.popViewController(animated: true)
        }
        authorDetailsController.onSavePhoto = { [weak self] imageData in
            print("onSavePhoto()")
            book.author?.photo = imageData
            try? self?.dataController.viewContext.save()
            debugPrint("Author photo saved successfully")
        }
        authorDetailsController.onSaveBio = { [weak self] bio in
            print("onSaveBio()")
            book.author?.bio = bio
            try? self?.dataController.viewContext.save()
            debugPrint("Author bio saved successfully")
        }
        self.navigationController?.pushViewController(authorDetailsController, animated: true)
    }

    func deleteAuthor(itemToDelete: Author) {
        print("Remove author from favourites")
        dataController.viewContext.delete(itemToDelete)
        try? dataController.viewContext.save()
        self.showToast(message: "Author removed from favourites successfully")
        debugPrint("Author removed from favourites successfully")
    }
}
