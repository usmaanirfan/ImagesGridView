//
//  GridViewController+Collection.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 21/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import UIKit

extension GridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.PhotoCellReuseIdentifier, for: indexPath)
        guard let photoCell = cell as? PhotoCell, let photo = self.items?[indexPath.item] else { return cell }
        if let image = ImageCache.publicCache.image(url: photo.pictureUrls.thumb as NSURL)  {
            photoCell.imageView.image = image
        } else {
            photoCell.imageView.image = UIImage(systemName: "rectangle")!
            self.loadImages(item: photo)
        }
        return photoCell
    }
}



//MARK: - UICollectionViewDelegate
extension GridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let itemsCount = self.items?.count ?? 0
        if indexPath.item == itemsCount - Constants.CellIdentifiers.prefetchCount {
            if let query = self.queryString, query.count > 0 {
                self.presenter?.searchItem(text:query, isStart: false)
            } else {
                self.presenter?.reloadData()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.Navigation.PhotoPreviewIdentifier, sender: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: Constants.CellIdentifiers.PhotoCellWidth, height: Constants.CellIdentifiers.PhotoCellHeight)
    }

    // 3
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }

    // 4
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }

}
