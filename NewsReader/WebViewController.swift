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
    @IBOutlet weak var webViewNavBar: UINavigationBar!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webViewNavBar.topItem?.title = "top news"
        webView.loadRequest(URLRequest(url: URL(string: url!)!))
    }

}
