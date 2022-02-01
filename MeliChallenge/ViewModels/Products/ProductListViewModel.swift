//
//  ProductListViewModel.swift
//  MeliChallenge
//
//  Created by Julian Perez on 31/01/22.
//

import Foundation

class ProductListViewModel {
    
    private var dataService: ProductListService?
    weak var binding: ProductListViewModelToViewBinding?
    
    var product: ListProducts?
    
    var succes: (() -> ())?
    var failure: (() -> ())?
    
    init(service: ProductListService? = nil, bingind: ProductListViewModelToViewBinding? = nil) {
        self.dataService = service
    }
     
    func fetchCategory(by name: String) {
        self.dataService?.requestCategory(by: name, completion: { [self] (model, error) in
            if let error = error {
                binding?.productViewModel(didGetProducts: model, error: error.localizedDescription)
                return
            }
            if let moMadxdel = model {
                product = model
                succes?()
            } else {
                failure?()
            }
        })
    }
}
  
// MARK: - Protocols
protocol ProductListViewModelToViewBinding: AnyObject {
   func productViewModel(didGetProducts products: ListProducts?, error: String?)
}
