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
    }
    
}
