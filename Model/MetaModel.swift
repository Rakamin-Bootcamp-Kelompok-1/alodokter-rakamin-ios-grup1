//
//  Meta.swift
//  Alodokter_bootcamp
//
//  Created by Putra on 16/12/21.
//

import Foundation

struct MetaModel: Codable {
    let page: String?
    let nextPage: Int?
    let totalPage: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case nextPage = "next_page"
        case totalPage = "total_page"
    }
}
