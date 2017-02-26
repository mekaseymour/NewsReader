//
//  Article.swift
//  NewsReader
//
//  Created by Meka Seymour on 1/30/17.
//  Copyright © 2017 Meka Seymour. All rights reserved.
//

import UIKit

class Article: NSObject {
    
    var headline: String?
    var desc: String?
    var author: String?
    var url: String?
    var imageUrl: String?
    var source: String?

    
    class func fetchArticles() -> [Article]{
        let headlines = UserDefaults.standard.array(forKey: "headline") as? [String] ?? [] // give a defaut value of an empty string
        let urls = UserDefaults.standard.array(forKey: "urls") as? [String] ?? []
        let sources = UserDefaults.standard.array(forKey: "sources") as? [String] ?? []
        
        var articles = [Article]()
        for(index, headline) in headlines.enumerated(){
            let article = Article()
            article.headline = headline
            article.url = urls[index]
            article.source = sources[index]
            
            
            articles.append(article)
        }
        
        return articles
        
    }
    
    func save() {
        var savedArticles = Article.fetchArticles()
        savedArticles.append(self)
        let headline = savedArticles.map{$0.headline}
        let urls = savedArticles.map{$0.url}
        let sources = savedArticles.map{$0.source}
        
        UserDefaults.standard.set(headline, forKey: "headline")
        UserDefaults.standard.set(urls, forKey: "urls")
        UserDefaults.standard.set(sources, forKey: "sources")
    
        
    }
    
    func remove() {
        
        var savedArticles = Article.fetchArticles()
        let index = savedArticles.index { (article) -> Bool in
            return article.url == self.url
        }
        if let index = index {
            savedArticles.remove(at: index)
        }
        let headline = savedArticles.map{$0.headline}
        let urls = savedArticles.map{$0.url}
        let sources = savedArticles.map{$0.source}
        
        UserDefaults.standard.set(headline, forKey: "headline")
        UserDefaults.standard.set(urls, forKey: "urls")
        UserDefaults.standard.set(sources, forKey: "sources")
    }
    
}
