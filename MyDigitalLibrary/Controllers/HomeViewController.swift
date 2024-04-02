//
//  HomeViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource {
    
    var books: [Book] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("HomeViewController viewDidLoad()")
        
        self.tableView.dataSource = self
        
        OpenLibraryClient.searchBook(bookTitle: "lord+of+the+rings") { result, error in
            //print("searchBook() result: \(result)")
            print("searchBook() success")
            self.books = result
            DispatchQueue.main.async {
                print("reloading data start...")
                self.tableView.reloadData()
                print("reloading data end...")            }
        }
        
    }


}

