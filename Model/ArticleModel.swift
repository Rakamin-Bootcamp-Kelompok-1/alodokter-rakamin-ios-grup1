//
//  DummyAlbumsModel.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/9/21.
//

import Foundation

struct ArticleData: Codable {
    let data: [ArticleModel]
}

struct ArticleModel: Codable {
    
    let id : Int?
    let article_category : String?
    let article_title: String?
    let image_url: String?
    let content_desc: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case article_category = "article_category"
        case article_title = "article_title"
        case image_url = "image_data"
        case content_desc = "content_desc"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        article_category = try values.decodeIfPresent(String.self, forKey: .article_category)
        article_title = try values.decodeIfPresent(String.self, forKey: .article_title)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        content_desc = try values.decodeIfPresent(String.self, forKey: .content_desc)
    }
}

