//
//  AuthorsCollectionViewController+CollectionViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 04/04/24.
//

import UIKit

extension AuthorsCollectionViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return authors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AuthorCollectionViewCell", for: indexPath) as! AuthorCollectionViewCell
        
        let author = authors[(indexPath as! IndexPath).row]
        cell.authorLabel.text = author.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionView select() \(indexPath)")
        let searchResultController = self.storyboard!.instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
        let author = authors[(indexPath as NSIndexPath).row]
        searchResultController.key = author.key
        searchResultController.imageId = author.imageId
        searchResultController.titleText = author.title
        searchResultController.descriptionText = author.description
        searchResultController.type = SearchEnum.author
        self.navigationController?.pushViewController(searchResultController, animated: true)
    }
    
}
