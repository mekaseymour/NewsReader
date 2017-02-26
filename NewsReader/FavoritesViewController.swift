//
//  FavoritesViewController.swift
//  NewsReader
//
//  Created by Meka Seymour on 2/4/17.
//  Copyright © 2017 Meka Seymour. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var favoritesTable: UITableView!
    
    let webVC = WebViewController()
    
    let articles = Article.fetchArticles()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoritesTable.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritedTableViewCell
        
       cell.urlLabel.text = articles[indexPath.item].headline
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.articles?.count ?? 0
        
        return articles.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewController
        
        webVC.article = self.articles[indexPath.item]
        
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    
}
