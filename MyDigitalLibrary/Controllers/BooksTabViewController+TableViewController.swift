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
        
        self.navigationController?.pushViewController(bookDetailsController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func deleteBook(itemToDelete: Book) {
        print("Remove book from favourites")
        dataController.viewContext.delete(itemToDelete)
        try? dataController.viewContext.save()
        debugPrint("Book removed from favourites successfully")
    }

}
