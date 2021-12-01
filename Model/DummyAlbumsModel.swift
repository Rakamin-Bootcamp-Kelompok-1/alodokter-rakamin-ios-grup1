//
//  DummyAlbumsModel.swift
//  Alodokter_bootcamp
//
//  Created by Abdul Aziz on 20/11/21.
//

import Foundation

struct DummyAlbumsModel : Codable {
    
    let albumId : Int?
    let id : Int?
    let title : String?
    let url: String?
    let thumbnailUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case albumId = "albumId"
        case id = "Int"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        albumId = try values.decodeIfPresent(Int.self, forKey: .albumId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        thumbnailUrl = try values.decodeIfPresent(String.self, forKey: .thumbnailUrl)
    }
    
}

