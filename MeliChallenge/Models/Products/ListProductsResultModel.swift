//
//  ListProductsResultModel.swift
//  MeliChallenge
//
//  Created by Julian Perez on 31/01/22.
//

import Foundation

public struct ListProductsResult : Codable {
    let acceptsMercadopago : Bool?
    let availableQuantity : Int?
    let condition : String?
    let currencyId : String?
    let id : String?
    let price : Double?
    let siteId : String?
    let soldQuantity : Int?
    let thumbnail : String?
    let title : String?

    enum CodingKeys: String, CodingKey {
         case acceptsMercadopago = "accepts_mercadopago"
         case availableQuantity = "available_quantity"
         case condition = "condition"
         case currencyId = "currency_id"
         case id = "id"
         case price = "price"
         case siteId = "site_id"
         case soldQuantity = "sold_quantity"
         case thumbnail = "thumbnail"
         case title = "title"
    }

    public init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
         acceptsMercadopago = try values.decodeIfPresent(Bool.self, forKey: .acceptsMercadopago)
         availableQuantity = try values.decodeIfPresent(Int.self, forKey: .availableQuantity)
         condition = try values.decodeIfPresent(String.self, forKey: .condition)
         currencyId = try values.decodeIfPresent(String.self, forKey: .currencyId)
         id = try values.decodeIfPresent(String.self, forKey: .id)
         price = try values.decodeIfPresent(Double.self, forKey: .price)
         siteId = try values.decodeIfPresent(String.self, forKey: .siteId)
         soldQuantity = try values.decodeIfPresent(Int.self, forKey: .soldQuantity)
         thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
         title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}

