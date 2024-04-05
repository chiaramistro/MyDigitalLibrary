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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableView didSelectRowAt() \(indexPath)")
        let detailsController = self.storyboard!.instantiateViewController(withIdentifier: "LibraryDetailsViewController") as! LibraryDetailsViewController
        let searchItem = searchResults[(indexPath as NSIndexPath).row]
        detailsController.key = searchItem.key
        detailsController.imageId = searchItem.imageId
        detailsController.titleText = searchItem.title
        detailsController.type = type
        self.navigationController?.pushViewController(detailsController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
