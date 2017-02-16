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
    
    let defaults = UserDefaults.standard
    
    var url: String?
    var navTitle: String?
    var articleTitle: String?
    var favoritedArticles = [String] ()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if userDefaults is nil, set it
        
        // if url in user defaults array, set rightbarbuttonitem to filled in heart, else set to empty heart
        
        if let storedData = UserDefaults.standard.array(forKey: "favoritedArticles") as? [String] {
            favoritedArticles = storedData
        } else {
            UserDefaults.standard.set(favoritedArticles, forKey: "favoritedArticles")
            print(UserDefaults.standard.array(forKey: "favoritedArticles") ?? [String]())
            //favoritedArticles = UserDefaults.standard.array(forKey: "favoritedAticles") as? [String]
        }
        //let data = UserDefaults.standard.dictionary(forKey: "favoritedArticles") as? [String:String]
        
        //if (data?.values.contains(url!))! {
        

        if (favoritedArticles.contains(url!)) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "red-heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        }
        else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "white-heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        }
    
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "white-heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        
        webView.loadRequest(URLRequest(url: URL(string: url!)!))
    }
    
    
    @IBAction func heartIconPressed(_ sender: UIBarButtonItem) {
        
        // set user defaults to array variable
        
        //var storedData = UserDefaults.standard.array(forKey: "favoritedArticles") as! Array<String>
        
        //var storedData = UserDefaults.standard.dictionary(forKey: "favoritedArticles") as? [String:String]
        
        // if article is favorited, save url to user defaults
        
        if navigationItem.rightBarButtonItem?.image != #imageLiteral(resourceName: "red-heart") {
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "red-heart")
            
            // append favorited url to user defaults
            
            favoritedArticles.append(url!)
            //storedData?[articleTitle!] = url
            
            // reset user defaults
            defaults.set(favoritedArticles, forKey: "favoritedArticles")
            
        }
        
        // else (if the article is unfavorited), remove from user defaults
            
        else {
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "white-heart")
            
            while favoritedArticles.contains(url!) {
            //while (storedData?.values.contains(url!))! {
                let elementIndex = favoritedArticles.index(of: url!)
                
                favoritedArticles.remove(at: elementIndex!)
                //storedData?.removeValue(forKey: url!)
                defaults.set(favoritedArticles, forKey: "favoritedArticles")
            }
        }
        
        print(UserDefaults.standard.array(forKey: "favoritedArticles") ?? [String]())
        //print(UserDefaults.standard.object(forKey: "favoritedArticles") ?? [String:String]())
    }
    
}

