//
//  Constants.swift
//  ParserExample
//
//  Created by Jesus Jaime Cano Terrazas on 07/08/21.
//

import Foundation

struct Constants {
    struct API {
        static let xmlURLStr = "https://www.mobilestudio.mx/iphone/parser/books.xml"
        static let jsonURLStr = "https://www.mobilestudio.mx/iphone/parser/books.json"
    }
    
    struct Keys {
        static let book = "book"
        static let id = "id"
        static let author = "author"
        static let title = "title"
        static let genre = "genre"
        static let price = "price"
        static let publishDate = "publish_date"
        static let description = "description"
    }
}
