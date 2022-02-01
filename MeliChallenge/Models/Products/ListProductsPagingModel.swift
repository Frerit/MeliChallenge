//
//  ListProductsPagingModel.swift
//  MeliChallenge
//
//  Created by Julian Perez on 31/01/22.
//

import Foundation

public struct ListProductsPaging: Codable {
    let limit : Int?
    let offset : Int?
    let primaryResults : Int?
    let total : Int?

    enum CodingKeys: String, CodingKey {
       case limit = "limit"
       case offset = "offset"
       case primaryResults = "primary_results"
       case total = "total"
    }
   
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        primaryResults = try values.decodeIfPresent(Int.self, forKey: .primaryResults)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }

}
