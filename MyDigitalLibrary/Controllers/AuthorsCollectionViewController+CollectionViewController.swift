//
//  AuthorsCollectionViewController+CollectionViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 04/04/24.
//

import UIKit

extension AuthorsCollectionViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AuthorCollectionViewCell", for: indexPath) as! AuthorCollectionViewCell
        
        let author = fetchedResultsController.object(at: indexPath)
        
        cell.authorLabel.text = author.name
        if let authorPhoto = author.photo {
            cell.imageView.image = UIImage(data: authorPhoto)
        } else {
            cell.imageView.image = UIImage(named: "image-placeholder")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionView select() \(indexPath)")
        let authorDetailsController = self.storyboard!.instantiateViewController(withIdentifier: "AuthorDetailsViewController") as! AuthorDetailsViewController
        let author = fetchedResultsController.object(at: indexPath)
        authorDetailsController.author = author
        authorDetailsController.onRemoveAuthor = { [weak self] in
            print("onRemoveAuthor()")
            self?.deleteAuthor(itemToDelete: author)
            self?.navigationController?.popViewController(animated: true)
        }
        authorDetailsController.onSavePhoto = { [weak self] imageData in
            print("onSavePhoto()")
            author.photo = imageData
            try? self?.dataController.viewContext.save()
            debugPrint("Author photo saved successfully")
        }
        authorDetailsController.onSaveBio = { [weak self] bio in
            print("onSaveBio()")
            author.bio = bio
            try? self?.dataController.viewContext.save()
            debugPrint("Author bio saved successfully")
        }
        self.navigationController?.pushViewController(authorDetailsController, animated: true)
    }
    
    func deleteAuthor(itemToDelete: Author) {
        print("Remove author from favourites")
        dataController.viewContext.delete(itemToDelete)
        try? dataController.viewContext.save()
        debugPrint("Author removed from favourites successfully")
    }
}
