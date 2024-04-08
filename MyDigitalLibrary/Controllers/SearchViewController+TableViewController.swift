//
//  SearchViewController+TableViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 04/04/24.
//

import UIKit

extension SearchViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView numberOfRowsInSection: \(searchResults.count)")
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView cellForRowAt \(indexPath)")
        
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
            let author = Author(context: self.dataController.viewContext)
            author.key = selectedResult.bookAuthorKey
            author.photoKey = selectedResult.bookAuthorKey
            author.name = selectedResult.bookAuthorName
            book.authorData = author
        }
        try? self.dataController.viewContext.save()
        debugPrint("New book saved successfully")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableView didSelectRowAt() \(indexPath)")
    }

}
