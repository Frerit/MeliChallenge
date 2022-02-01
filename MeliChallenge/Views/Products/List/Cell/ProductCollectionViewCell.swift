//
//  ProductCollectionViewCell.swift
//  MeliChallenge
//
//  Created by Julian Perez on 31/01/22.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let identifier = "ProductCollectionViewCell"
    override var reuseIdentifier: String? { return ProductCollectionViewCell.identifier }
     
    var data: ListProductsResult? {
        didSet {
            setupCell()
            self.sizeToFit()
        }
    }
    
    func setupCell() {
        
        self.priceLabel.text = "$\(getCurrenciValue(data?.price ?? 0)) \(data?.currencyId ?? "")"
        self.descriptionLabel.text = data?.title
        let imageSecure = data?.thumbnail?.replacingOccurrences(of: "http://", with: "https://") ?? ""
        self.imageView.sd_setImage(with: URL(string: imageSecure), placeholderImage: UIImage(named: "placeholder-image")  )
        self.sizeToFit()
    }
    
   
}
