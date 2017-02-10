//
//  WebViewController.swift
//  NewsReader
//
//  Created by Meka Seymour on 2/1/17.
//  Copyright © 2017 Meka Seymour. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var url: String?
    var navTitle: String?
    var favoriteArticle: String?
    //var heartIcon: UIBarButtonItem?
    var favoriteArticles = [String]()
    
    //let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        webView.loadRequest(URLRequest(url: URL(string: url!)!))
        
    }
    
  
    @IBAction func heartIconPressed(_ sender: UIBarButtonItem) {
        favoriteArticle = url!
        //favoriteArticles.append(url!)
        //print(favoriteArticles)
        UserDefaults.standard.set(favoriteArticle, forKey: "articleUrl")
    }
    
}

