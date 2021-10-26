//
//  Book.swift
//  ParserExample
//
//  Created by Jesus Jaime Cano Terrazas on 14/08/21.
//

import Foundation

class Book: Codable {
    var id = ""
    var author = ""
    var title = ""
    var genre = ""
    var price = ""
    var publishDate = ""
    var description = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case title
        case genre
        case price
        case publishDate = "publish_date"
        case description
    }
}
