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
        let detailsController = self.storyboard!.instantiateViewController(withIdentifier: "LibraryDetailsViewController") as! LibraryDetailsViewController
        let book = books[(indexPath as NSIndexPath).row]
        detailsController.key = book.key
        detailsController.imageId = book.imageId
        detailsController.titleText = book.title
        detailsController.descriptionText = book.description
        detailsController.type = SearchEnum.book
        detailsController.isFavorite = true
        self.navigationController?.pushViewController(detailsController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
