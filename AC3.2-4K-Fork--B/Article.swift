//
//  Article.swift
//  AC3.2-4K-Fork--B
//
//  Created by Tom Seymour on 12/1/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import Foundation


class Article : NSObject {
    let section: String
    let subsection: String
    let title: String
    let abstract: String
    let url: String
    let byline: String
    let publishedDate: String
    
    init(section: String, subsection: String, title: String, abstract: String, url: String, byline: String, publishedDate: String) {
        self.section = section
        self.subsection = subsection
        self.title = title
        self.abstract = abstract
        self.url = url
        self.byline = byline
        self.publishedDate = publishedDate
    }
}
