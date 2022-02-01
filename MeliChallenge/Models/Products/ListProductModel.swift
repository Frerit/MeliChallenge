//
//  ListProductModel.swift
//  MeliChallenge
//
//  Created by Julian Perez on 31/01/22.
//

import Foundation

import Foundation

public struct ListProducts: Codable {

    let paging : ListProductsPaging?
    let query : String?
    let results : [ListProductsResult]?
    let siteId : String?

    enum CodingKeys: String, CodingKey {
        case paging = "paging"
        case query = "query"
        case results = "results"
        case siteId = "site_id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        paging = try values.decodeIfPresent(ListProductsPaging.self, forKey: .paging)
        query = try values.decodeIfPresent(String.self, forKey: .query)
        results = try values.decodeIfPresent([ListProductsResult].self, forKey: .results)
        siteId = try values.decodeIfPresent(String.self, forKey: .siteId)
    }
}
