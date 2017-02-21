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
    
    var url: String?
    var navTitle: String?
    var articleTitle: String?
    var favoritedArticles = [String] ()
    
    // <---- for dictionary ---->
    
    var favoritedArticlesDict = [String:[String]] ()
    var favoritedUrls = [String] ()
    var favoritedTitles = [String] ()
    var favoritedSources = [String] ()
    
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if userDefaults is nil, set it
        
        //if let storedData = UserDefaults.standard.array(forKey: "favoritedArticles") as? [String] {
        if let storedData = UserDefaults.standard.dictionary(forKey: "favoritedArticles") as? [String:[String]] {
            //favoritedArticles = storedData
            favoritedArticlesDict = storedData
            favoritedUrls = storedData["urls"]!
            favoritedTitles = storedData["titles"]!
            favoritedSources = storedData["sources"]!
            
        } else {
            //UserDefaults.standard.set(favoritedArticles, forKey: "favoritedArticles")
            UserDefaults.standard.set(favoritedArticlesDict, forKey: "favoritedArticles")
            //print(UserDefaults.standard.array(forKey: "favoritedArticles") ?? [String]())
            print(UserDefaults.standard.object(forKey: "favoritedArticles") ?? [String:[String]]())
        }
        
        // display aprropriate heart icon
        getHeartIcon()
        
        webView.loadRequest(URLRequest(url: URL(string: url!)!))
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
        
        //print(UserDefaults.standard.array(forKey: "favoritedArticles") ?? [String]())
        //print(UserDefaults.standard.object(forKey: "favoritedArticles") ?? [String:[String]]())
        print(favoritedArticlesDict)
    }
    
    func getHeartIcon() {
         // if url in user defaults array, set rightbarbuttonitem to filled in heart, else set to empty heart
        if (favoritedUrls.contains(url!)) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "red-heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "white-heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        }
    }
    
    func addToFavorites() {
        //favoritedArticles.append(url!)
        //defaults.set(favoritedArticles, forKey: "favoritedArticles")
        
        // <---- for dictionary ---->
        favoritedUrls.append(url!)
        favoritedTitles.append(articleTitle!)
        favoritedSources.append(navTitle!)
        favoritedArticlesDict["urls"] = favoritedUrls
        favoritedArticlesDict["titles"] = favoritedTitles
        favoritedArticlesDict["sources"] = favoritedSources
        
        defaults.set(favoritedArticlesDict, forKey: "favoritedArticles")
        
    }
    
    func removeFromFavorites() {
        // remove all occurances of article in favoritedArticles array
        //while favoritedArticles.contains(url!) {
        while favoritedUrls.contains(url!) {
            //let elementIndex = favoritedArticles.index(of: url!)
            let elementIndex = favoritedUrls.index(of: url!)
            
            //favoritedArticles.remove(at: elementIndex!)
            favoritedUrls.remove(at: elementIndex!)
            favoritedTitles.remove(at: elementIndex!)
            favoritedSources.remove(at: elementIndex!)
            
            favoritedArticlesDict["urls"] = favoritedUrls
            favoritedArticlesDict["titles"] = favoritedTitles
            favoritedArticlesDict["sources"] = favoritedSources
            
            //storedData?.removeValue(forKey: url!)
            defaults.set(favoritedArticlesDict, forKey: "favoritedArticles")
        }
    }
    
}

