//
//  ListModel.swift
//  MyNews
//
//  Created by user on 17.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct  ListNews: Codable {
    enum CodingKeys: String, CodingKey {
        case articles
    }
    var articles: [New]
}

struct New: Codable {
    var author: String?
    var title: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var source: String?

    enum CodingKeys: String, CodingKey {
        case author
        case title
        case url
        case urlToImage
        case publishedAt
        case source
    }
    
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(title, forKey: .title)
      try container.encode(author, forKey: .author)
      try container.encode(url, forKey: .url)
      try container.encode(urlToImage, forKey: .urlToImage)
      try container.encode(publishedAt, forKey: .publishedAt)
        try container.encode(source, forKey: .source)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

         self.author = try? container.decode(String.self, forKey: .author)
         self.title = try? container.decode(String.self, forKey: .title)
         self.url = try? container.decode(String.self, forKey: .url)
         self.urlToImage = try? container.decode(String.self, forKey: .urlToImage)
         self.publishedAt = try? container.decode(String.self, forKey: .publishedAt)
        self.source = try? container.decode(String.self, forKey: .source)
        
        if let dateStr = self.publishedAt {
            self.publishedAt = convertDate(strDate: dateStr)
        }
    }
    
    private func convertDate(strDate: String) -> String {
        
        
     let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateObj = dateFormatter.date(from: strDate)
        if dateObj != nil {
        dateFormatter.dateFormat = "EEEE, MMM d"
        let dateString = dateFormatter.string(from: dateObj!)
        return dateString
        } else {
            return "no date"
        }
    }
}

struct NewEncod: Codable {
    var author: String?
    var title: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var source: String?

    enum CodingKeys: String, CodingKey {
        case author
        case title
        case url
        case urlToImage
        case publishedAt
        case source
    }
    
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(title, forKey: .title)
      try container.encode(author, forKey: .author)
      try container.encode(url, forKey: .url)
      try container.encode(urlToImage, forKey: .urlToImage)
      try container.encode(publishedAt, forKey: .publishedAt)
        try container.encode(source, forKey: .source)
    }

}

