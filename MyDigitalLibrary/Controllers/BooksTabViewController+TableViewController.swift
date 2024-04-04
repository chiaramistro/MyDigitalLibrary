//
//  BooksTabViewController+TableViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit

extension BooksTabViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView numberOfRowsInSection: \(books.count)")
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView cellForRowAt \(indexPath)")
        
        let book = books[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

        // Configure cell
        cell.textLabel?.text = book.title

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchResultController = self.storyboard!.instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
        let book = books[(indexPath as NSIndexPath).row]
        searchResultController.key = book.key
        searchResultController.imageId = book.imageId
        searchResultController.titleText = book.title
        searchResultController.descriptionText = book.description
        searchResultController.type = SearchEnum.book
        self.navigationController?.pushViewController(searchResultController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
