//
//  WebViewController.swift
//  NewsReader
//
//  Created by Meka Seymour on 2/1/17.
//  Copyright © 2017 Meka Seymour. All rights reserved.
//

import UIKit
import CoreData

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var article: Article?
    
    var favoritedArticles = [String] ()
    
    // <---- for dictionary ---->
    
    var favoritedArticlesDict = [String:[String]] ()
    
    let defaults = UserDefaults.standard
    let urls = UserDefaults.standard.array(forKey: "urls") as? [String] ?? []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = article?.headline
        
        // display aprropriate heart icon
        getHeartIcon()
        
        webView.loadRequest(URLRequest(url: URL(string: (article?.url!)!)!))
    }
    
    
    @IBAction func heartIconPressed(_ sender: UIBarButtonItem) {
        
        // if article is favorited, save url to user defaults
        
        if navigationItem.rightBarButtonItem?.image != #imageLiteral(resourceName: "red-heart") {
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "red-heart")
            addToFavorites()
            
        }
        
        // else (if the article is unfavorited), remove from user defaults
            
        else {
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "white-heart")
            removeFromFavorites()
        }
    }
    
    func getHeartIcon() {
        
        let favoritedUrls: [String] = Article.fetchArticles().map{$0.url ?? ""}
        
         // if url in user defaults array, set rightbarbuttonitem to filled in heart, else set to empty heart
        if (favoritedUrls.contains((article?.url)!)) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "red-heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "white-heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        }
    }
    
    func addToFavorites() {

        article?.save()
        
    }
    
    func removeFromFavorites() {
        
        article?.remove()

    }
}


