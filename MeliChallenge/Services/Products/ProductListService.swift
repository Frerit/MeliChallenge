//
//  ProductListService.swift
//  MeliChallenge
//
//  Created by Julian Perez on 31/01/22.
//

import Foundation
import Alamofire

struct ProductListService {
    
    // MARK: - Singleton
    static let shared = ProductListService()
    
    // MARK: - URL
    private var base = "https://api.mercadolibre.com/sites"
    
    
    func get(url: String, completion: @escaping (Data?, Error?) -> ()) {
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                    case .success:
                        let result = response.data
                        completion(result, nil)
                        return
                    case let .failure(error):
                        completion(nil, error)
                        return
                }
        }
    }
    
    // MARK: - Services
    func requestCategory(by name: String, completion: @escaping (ListProducts?, Error?) -> ()) {
        let url = "\(base)/MLA/search?q=\(name)"
        
        get(url: url) { (data, error) in
            do {
                guard let serialData = data else { return completion(nil, nil) }
                let products = try JSONDecoder().decode(ListProducts.self, from: data! as Data)
                completion(products, nil)
            } catch let e as NSError {
                completion(nil, e)
            }
        }
    }
}
