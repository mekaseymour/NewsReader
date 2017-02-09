//
//  MenuManager.swift
//  NewsReader
//
//  Created by Meka Seymour on 2/2/17.
//  Copyright © 2017 Meka Seymour. All rights reserved.
//

import UIKit

class MenuManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    let blackView = UIView()
    let menuTableView = UITableView()
    let arrayOfSources = ["TechCrunch", "TechRadar", "Recode"]
    var mainVC: ViewController?

    
    public func openMenu() {
        // if we have a window, we want to do some stuff
        if let window = UIApplication.shared.keyWindow {
            blackView.frame = window.frame
            // white: 1 makes the background white and white: 0 makes the background black, alpha 0.5 gives the blackView some transparency
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissMenu)))
            
            // define height as the number of rows times 50 (the set height of each row)
            let height: CGFloat = CGFloat((arrayOfSources.count)) * 50
            
            let y = window.frame.height - CGFloat(height)
            
            menuTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            window.addSubview(blackView)
            window.addSubview(menuTableView)
            
            UIView.animate(withDuration: 0.5, animations: {
                // change the alpha value
                self.blackView.alpha = 1
                
                //push it up by the height of the tableview
                self.menuTableView.frame.origin.y = y
            })
        }
    }
    
    public func dismissMenu() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            // if there's a window
            if let window = UIApplication.shared.keyWindow {
                // change the y to the bottom of the screen
                self.menuTableView.frame.origin.y = window.frame.height
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSources.count
    }
    
    // set table row heigth
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as UITableViewCell
        cell.textLabel?.text = arrayOfSources[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = mainVC {
            vc.source = arrayOfSources[indexPath.item]
            vc.fetchArticles(fromSource: arrayOfSources[indexPath.item])
            dismissMenu()
        }
    }
    
    override init() {
        // when I initialize this I'm overriding the initialization of NSObject
        super.init()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        // don't want the menu to be scroll enabled or to bouce
        menuTableView.isScrollEnabled = false
        menuTableView.bounces = false
        
        menuTableView.register(BaseViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
        
    }
    
}
