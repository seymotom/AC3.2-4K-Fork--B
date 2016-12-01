//
//  ViewController.swift
//  AC3.2-4K-Fork--B
//
//  Created by Tom Seymour on 12/1/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit
import TwicketSegmentedControl

class ViewController: UIViewController, TwicketSegmentedControlDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
  
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article] = []
    
    var uri = ["home", "arts", "sports"]
    
    
    var sectionTitles: [String] {
        get {
            var sectionSet = Set<String>()
            for article in articles {
                sectionSet.insert(article.section)
            }
            return Array(sectionSet).sorted()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        createTwicket()
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func createTwicket () {
        let titles = self.uri.map { $0.capitalized }
        let frame = CGRect(x: 5, y: view.frame.height - 50, width: view.frame.width - 10, height: 40)
        let segmentedControl = TwicketSegmentedControl(frame: frame)
        segmentedControl.setSegmentItems(titles)
        segmentedControl.delegate = self
        
        view.addSubview(segmentedControl)
    }
    
    func loadData(endpoint: String = "home") {
        let nytEndpoint = "https://api.nytimes.com/svc/topstories/v2/\(endpoint).json?api-key=f41c1b23419a4f55b613d0a243ed3243"
        NetworkManager.shared.getArticles(endpoint: nytEndpoint) { (theArticles) in
            DispatchQueue.main.async {
                if let unwrappedArticles = theArticles {
                    self.articles = unwrappedArticles
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return self.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let title = UILabel()
        title.font = UIFont(name: "Times New Roman", size: 16)!
        title.textColor = UIColor.darkGray
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionPredicate = NSPredicate(format: "section = %@", self.sectionTitles[section])
        return self.articles.filter { sectionPredicate.evaluate(with: $0)}.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! AricleTableViewCell
        
        let sectionPredicate = NSPredicate(format: "section = %@", self.sectionTitles[indexPath.section])
        let thisArticle = self.articles.filter { sectionPredicate.evaluate(with: $0)}[indexPath.row]
      
        cell.titleLabel.text = thisArticle.title
        cell.byLineLabel.text = ("\(thisArticle.byline)\n-\(thisArticle.publishedDate)")
        cell.abstractLabel.text = thisArticle.abstract

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionPredicate = NSPredicate(format: "section = %@", self.sectionTitles[indexPath.section])
        let thisArticle = self.articles.filter { sectionPredicate.evaluate(with: $0)}[indexPath.row]
        UIApplication.shared.open(URL(string: thisArticle.url)!, options: [:], completionHandler: nil)
    }
    
    func didSelect(_ segmentIndex: Int) {
        loadData(endpoint: self.uri[segmentIndex])
    }
    
    
    


}

