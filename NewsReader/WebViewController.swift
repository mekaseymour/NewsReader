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
    //var favoritedArticles = [String:[String]] -- declare a dictionary of arrays
    // var favoritedUrls = [String]()  --  declare arrays to populate dictionary
    // var favoritedTitles = [String]()  --  declare arrays to populate dictionary
    // favoritedArticles["urls"] = favoritedUrls
    // favoritedArticles["titles"] = favoritedTitles
    
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if userDefaults is nil, set it
        
        if let storedData = UserDefaults.standard.array(forKey: "favoritedArticles") as? [String] {
            favoritedArticles = storedData
        } else {
            UserDefaults.standard.set(favoritedArticles, forKey: "favoritedArticles")
            print(UserDefaults.standard.array(forKey: "favoritedArticles") ?? [String]())
        }
        //let data = UserDefaults.standard.dictionary(forKey: "favoritedArticles") as? [String:[String]]
        
        // display aprropriate heart icon
        getHeartIcon()
        
        webView.loadRequest(URLRequest(url: URL(string: url!)!))
    }
    
    
    @IBAction func heartIconPressed(_ sender: UIBarButtonItem) {
        
        // if article is favorited, save url to user defaults
        
        if navigationItem.rightBarButtonItem?.image != #imageLiteral(resourceName: "red-heart") {
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "red-heart")
            addToFavorites()
            
            // -- apped to arrays and set dictionary --
            // favoritedUrls.append(url!)
            // favoritedTitles.append(articleTitle!)
            // favoritedArticles["urls"] = favoritedUrls
            // favoritedArticles["titles"] = favoritedTitles
            
        }
        
        // else (if the article is unfavorited), remove from user defaults
            
        else {
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "white-heart")
            removeFromFavorites()
        }
        
        print(UserDefaults.standard.array(forKey: "favoritedArticles") ?? [String]())
        //print(UserDefaults.standard.object(forKey: "favoritedArticles") ?? [String:[String]]())
    }
    
    func getHeartIcon() {
         // if url in user defaults array, set rightbarbuttonitem to filled in heart, else set to empty heart
        if (favoritedArticles.contains(url!)) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "red-heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "white-heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        }
    }
    
    func addToFavorites() {
        favoritedArticles.append(url!)
        defaults.set(favoritedArticles, forKey: "favoritedArticles")
        
    }
    
    func removeFromFavorites() {
        // remove all occurances of article in favoritedArticles array
        while favoritedArticles.contains(url!) {
            //while (storedData?.values.contains(url!))! {
            let elementIndex = favoritedArticles.index(of: url!)
            
            favoritedArticles.remove(at: elementIndex!)
            //storedData?.removeValue(forKey: url!)
            defaults.set(favoritedArticles, forKey: "favoritedArticles")
        }
    }
    
}

