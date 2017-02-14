//
//  FavoritesViewController.swift
//  NewsReader
//
//  Created by Meka Seymour on 2/4/17.
//  Copyright © 2017 Meka Seymour. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    let webVC = WebViewController()
    
    var favoriteArticlesUrls = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let data = UserDefaults.standard.object(forKey: "favoritedArticles") as? [String]
        print(data ?? 0)
    }
 
}
