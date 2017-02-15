//
//  ViewController.swift
//  NewsReader
//
//  Created by Meka Seymour on 1/30/17.
//  Copyright © 2017 Meka Seymour. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableNavBar: UINavigationBar!

    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article]? = []
    var source = "TechCrunch" // give source a default value of "techcrunch"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchArticles(fromSource: source)
    }
    
    func fetchArticles(fromSource provider: String) {
        
        let lowercasedProvider = provider.lowercased()
        
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v1/articles?source=\(lowercasedProvider)&sortBy=top&apiKey=55e63fb8ae124a108dc838cbf3cc337a")!)
        
        // set the NavBar title to the name of the current news source
        title = provider
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "more news", style: .plain, target: self, action: #selector(menuPressed(_:)))
        
        let task = URLSession.shared.dataTask(with: urlRequest) {(data,response,error) in
            
            if error != nil {
                print(error ?? 0)
                return
            }
            
            //create articles object
            self.articles = [Article]()
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                
                if let articlesFromJson = json["articles"] as? [[String: AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        
                        //create article object
                        let article = Article()
                        
                        if let title = articleFromJson["title"] as? String, let author = articleFromJson["author"] as? String, let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String {
                            
                            article.headline = title
                            article.author = author
                            article.desc = desc
                            article.url = url
                            article.imageUrl = urlToImage
                
                        }
                        //put article element in the articles array
                        self.articles?.append(article)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print(error)
            }
            
        }
        //to fire the URLSession
        task.resume()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        
        cell.titleLabel.text = self.articles?[indexPath.item].headline
        cell.descriptionLabel.text = self.articles?[indexPath.item].desc
        cell.authorLabel.text = self.articles?[indexPath.item].author
        cell.imgView.downloadImage(from: ((self.articles?[indexPath.item].imageUrl))!)
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
        // ?? 0 means if self.articles?.count is nil, don't crash - use 0 value
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewController
        
        // get the url and pass it to the webVC
        
        webVC.url = self.articles?[indexPath.item].url
        webVC.navTitle = source
        //self.present(webVC, animated: true, completion: nil)
        
        // pass the article title to the webVC as well
        webVC.articleTitle = self.articles?[indexPath.item].headline
        
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    // create MenuManager object
    let menuManager = MenuManager()
    
    @IBAction func menuPressed(_ sender: UIBarButtonItem) {
        menuManager.openMenu()
        menuManager.mainVC = self
    }
    
}

extension UIImageView {
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            
            if error != nil {
                print(error ?? 0)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}













