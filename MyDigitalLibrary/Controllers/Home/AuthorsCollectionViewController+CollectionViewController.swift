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
            debugPrint("Author DOES have photo")
            cell.imageView.image = UIImage(data: authorPhoto)
        } else {
            debugPrint("Author DOES NOT have photo")
            // Try to fetch author photo
            cell.imageView.image = UIImage(named: "image-placeholder")
            OpenLibraryClient.getCoverImage(id: author.photoKey ?? "", type: SearchEnum.author) { image, error in
                print("getCoverImage() success")
                if let image = image {
                    print("getCoverImage() success \(image)")
                    cell.imageView.image = UIImage(data: image)
                    author.photo = image
                    try? self.dataController.viewContext.save()
                    debugPrint("Author photo saved successfully")
                } else {
                    debugPrint("Error no author's photo available: \(error?.localizedDescription)")
                    cell.imageView.image =  UIImage(named: "image-placeholder")
                }
            }
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
            self?.navigationController?.popToRootViewController(animated: true)
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
        self.showToast(message: "Author removed from favourites successfully")
        debugPrint("Author removed from favourites successfully")
    }
    
    func createRowLayout() -> UICollectionViewLayout {
        // Create item with size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Create a group with 3 items each
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.33))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        // Create section with group
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // Define spacing between two items
        let spacing = CGFloat(8)
        group.interItemSpacing = .fixed(spacing)
        section.interGroupSpacing = spacing
        
        // Embed section in layout and return it to collection view
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
