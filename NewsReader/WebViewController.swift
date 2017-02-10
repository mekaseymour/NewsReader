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
    //var heartIcon: UIBarButtonItem?
    var favoriteArticles = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "heart"), style: .plain, target: self, action: #selector(heartIconPressed(_:)))
        //webViewNavBar.topItem?.title = navTitle
        webView.loadRequest(URLRequest(url: URL(string: url!)!))
        
    }
    
  
    @IBAction func heartIconPressed(_ sender: UIBarButtonItem) {
        favoriteArticles.append(url!)
        print(favoriteArticles)
    }
    
}

