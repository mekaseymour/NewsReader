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
    //var favoritedArticles = [String]()
    
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "white-heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        webView.loadRequest(URLRequest(url: URL(string: url!)!))
        
    }
    
    
    @IBAction func heartIconPressed(_ sender: UIBarButtonItem) {
        
        
        if navigationItem.rightBarButtonItem?.image != #imageLiteral(resourceName: "red-heart") {
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "red-heart")
            
            //favoritedArticles.append(url!)
            //defaults.set(favoritedArticles, forKey: "favoritedArticles")
            
            var storedData = UserDefaults.standard.array(forKey: "favoritedArticles") as! Array<String>
            storedData.append(url!)
            defaults.set(storedData, forKey: "favoritedArticles")
            
        }
        else {
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "white-heart")
        }
        
        print(UserDefaults.standard.array(forKey: "favoritedArticles") ?? [String]())
    }
    
}

