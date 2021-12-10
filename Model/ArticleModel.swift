//
//  DummyAlbumsModel.swift
//  Alodokter_bootcamp
//
//  Created by Jeremy Endratno on 12/9/21.
//

import Foundation

struct ArticleModel : Codable {
    
    let id : Int?
    let title : String?
    let imageUrl: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case imageUrl = "url"
        case content = "content"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        content = try values.decodeIfPresent(String.self, forKey: .content)
    }
}

