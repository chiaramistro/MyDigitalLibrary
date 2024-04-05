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
        bookDetailsController.dataController = dataController
        self.navigationController?.pushViewController(bookDetailsController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
