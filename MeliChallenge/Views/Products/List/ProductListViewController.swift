//
//  ProductListViewController.swift
//  MeliChallenge
//
//  Created by Julian Perez on 31/01/22.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    let searchController = UISearchController(searchResultsController: nil)
    let referenceProductCell = Bundle.main.loadNibNamed(ProductCollectionViewCell.identifier, owner: ProductCollectionViewCell.self, options: nil)?.first as? ProductCollectionViewCell
    
    var startIndex: Int32 = 0
    var endIndex: Int32 = 19
    
    var product: [ListProductsResult]?
    var selectecProduct: ListProductsResult?
    
    // MARK: - Injection
    var viewModel = ProductListViewModel(service: ProductListService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProductListViewModel(service: ProductListService(), bingind: self)
        setupUI()
        setupCollection()
        setupViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GoToDetailProduct") {
            let destinationVC = segue.destination as? ProductDetailViewController
            destinationVC!.detail = self.selectecProduct
            navigationItem.backBarButtonItem?.title = "Atras"
        } else {
            print("")
        }
    }
}

// MARK: - Setup UI
extension ProductListViewController {
    func setupUI() {
        setUpStatusBar(backgroundColor: #colorLiteral(red: 1, green: 0.9450980392, blue: 0.3490196078, alpha: 1))
        searchController.searchBar.backgroundColor = #colorLiteral(red: 1, green: 0.9450980392, blue: 0.3490196078, alpha: 1)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 0.9450980392, blue: 0.3490196078, alpha: 1)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    func setupCollection() {
        let layout = CHTCollectionViewWaterfallLayout()
        productsCollectionView.collectionViewLayout = layout
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.register(
            UINib(nibName: "ProductCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: ProductCollectionViewCell.identifier
        )
    }
    
    func setupViewModel() {
        viewModel.fetchCategory(by: "Mazda")
        
        viewModel.succes = {
            self.product = self.viewModel.product?.results
            self.errorView.isHidden = true
            self.productsCollectionView.reloadData()
        }
        
        viewModel.failure = {
            self.product = []
            self.productsCollectionView.reloadData()
            self.errorView.isHidden = false
        }
    }
}

extension ProductListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchCategory(by: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchCategory(by: "Mazda")
    }
}

extension ProductListViewController: ProductListViewModelToViewBinding {
    func productViewModel(didGetProducts products: ListProducts?, error: String?) {
        if error != nil {
            self.product?.removeAll()
            self.productsCollectionView.reloadData()
            self.errorView.isHidden = false
        } else {
            self.product = products?.results
            self.errorView.isHidden = true
            productsCollectionView.reloadData()
        }
    }
}
 
