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
    
    var articles = Article.fetchArticles()
    
    var favorited_articles_headlines: [String] = []
    
    var reversed_order_headlines: [String] = []
    
    var reversed_articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadArticles()
    }
    
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoritesTable.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritedTableViewCell
        
        cell.urlLabel.text = reversed_articles[indexPath.item].headline
        //cell.urlLabel.text = reversed_order_headlines[indexPath.item]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.articles?.count ?? 0
        
        return reversed_articles.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewController
        
        webVC.article = self.reversed_articles[indexPath.item]
        
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            reversed_articles[indexPath.item].remove()
            
            reloadArticles()
        }
    }
    
    // MARK: - Helper Methods
    private func reloadArticles() {
        articles = Article.fetchArticles()
        reversed_articles = articles.reversed()
        
        favoritesTable.reloadData()
    }
    
    
}
