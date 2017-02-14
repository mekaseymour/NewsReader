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
    var favoritedArticles = [String]()
    
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if url in user defaults array, set rightbarbuttonitem to filled in heart, else set to empty heart
        
        let data = UserDefaults.standard.object(forKey: "favoritedArticles") as? [String]
        if (data?.contains(url!))! {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "red-heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        }
        else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "white-heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        }
        
        webView.loadRequest(URLRequest(url: URL(string: url!)!))
    }
    
    
    @IBAction func heartIconPressed(_ sender: UIBarButtonItem) {
        
        // set user defaults to array variable
        var storedData = UserDefaults.standard.array(forKey: "favoritedArticles") as! Array<String>
        
        // if article is favorited, save url to user defaults
        
        if navigationItem.rightBarButtonItem?.image != #imageLiteral(resourceName: "red-heart") {
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "red-heart")
            
            // append favorited url to user defaults
            storedData.append(url!)
            // reset user defaults
            defaults.set(storedData, forKey: "favoritedArticles")
            
        }
        
        // else (if the article is unfavorited), remove from user defaults
            
        else {
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "white-heart")
            
            while storedData.contains(url!) {
                let elementIndex = storedData.index(of: url!)
                storedData.remove(at: elementIndex!)
                defaults.set(storedData, forKey: "favoritedArticles")
            }
        }
        
        print(UserDefaults.standard.array(forKey: "favoritedArticles") ?? [String]())
    }
    
}

