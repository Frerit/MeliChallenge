//
//  ProductListDelegates.swift
//  MeliChallenge
//
//  Created by Julian Perez on 31/01/22.

import CHTCollectionViewWaterfallLayout
import UIKit

extension ProductListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                            .dequeueReusableCell(
                                withReuseIdentifier: ProductCollectionViewCell.identifier,
                                for: indexPath) as? ProductCollectionViewCell
        else { return UICollectionViewCell()  }
        cell.data = product![indexPath.item]
        return cell
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectecProduct = self.product![indexPath.item]
        self.performSegue(withIdentifier: "GoToDetailProduct", sender: self)
    }
}

extension ProductListViewController: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize {
        let numOfColumns: CGFloat = 2
        let spaceBetweenCells: CGFloat = 5
        if collectionView.collectionViewLayout is UICollectionViewFlowLayout {
            let cellWidth = (collectionView.bounds.width - 8)/numOfColumns -  (spaceBetweenCells/2)
            return CGSize(width: cellWidth, height: 412)
        } else {
            guard let referenceProductCell = self.referenceProductCell else { return CGSize() }
            referenceProductCell.data = self.product![indexPath.item]
            let cellWidth = collectionView.bounds.width/2 - 4
            let computedSize = referenceProductCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            let cellHeight = computedSize.height
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
}
