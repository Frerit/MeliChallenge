//
//  ProductDetailViewController.swift
//  MeliChallenge
//
//  Created by Julian Perez on 31/01/22.
//

import Foundation
import UIKit
import SDWebImage

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
     
    var detail: ListProductsResult?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = detail?.title
        self.navigationController?.navigationBar.backItem?.title = "Atras"
        self.priceLabel.text = "$\(getCurrenciValue(detail?.price ?? 0)) \(detail?.currencyId ?? "")"
        self.titleLabel.text = detail?.title
        self.descriptionLabel.text = detail?.siteId
        let imageSecure = detail?.thumbnail?.replacingOccurrences(of: "http://", with: "https://") ?? ""
        self.imageView.sd_setImage(with: URL(string: imageSecure), placeholderImage: UIImage(named: "placeholder-image") )
    }
     

}
