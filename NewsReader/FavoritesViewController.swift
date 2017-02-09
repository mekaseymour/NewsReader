//
//  FavoritesViewController.swift
//  NewsReader
//
//  Created by Meka Seymour on 2/4/17.
//  Copyright © 2017 Meka Seymour. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesTextField: UITextView!
    
    var favoriteArticlesUrls = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        getFavorites()
    }
    
    func getFavorites() {
        // create webVC object from WebViewController class
        let webVC = WebViewController()
        
        self.favoriteArticlesUrls = webVC.favoriteArticles
        print(favoriteArticlesUrls)
        
        }
}
