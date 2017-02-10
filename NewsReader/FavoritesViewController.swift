//
//  FavoritesViewController.swift
//  NewsReader
//
//  Created by Meka Seymour on 2/4/17.
//  Copyright © 2017 Meka Seymour. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    let webVC = WebViewController()
    
    var favoriteArticlesUrls = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let favoriteArticles = UserDefaults.standard.object(forKey: "articleUrl") as? String {
            print(favoriteArticles)
            outputLabel.text = favoriteArticles
        }
    }
 
}
