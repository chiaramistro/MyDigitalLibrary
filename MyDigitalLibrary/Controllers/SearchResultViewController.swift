//
//  SearchResultViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 03/04/24.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var result: String!
    
    // FIXME remove, just for testing
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        print("SearchResultViewController viewDidLoad()")
        print("SearchResultViewController viewDidLoad() result \(result)")
        
        navigationItem.title = "Details"

        textLabel.text = result
    }
}
