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
    
    //var favoriteArticlesUrls = [String]()
    
    let data = UserDefaults.standard.object(forKey: "favoritedArticles") as? Array<String>
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print(data ?? 0)
    }
    
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoritesTable.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoritedTableViewCell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        
        cell.urlLabel.text = self.data?[indexPath.item]
        //cell.titleLabel.text = self.data?[indexPath.item]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewController
        
        webVC.url = self.data?[indexPath.item]
        
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    
}
