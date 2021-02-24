//
//  ViewController.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 20/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {
    
    var presenter : GridViewPreseneterInterface?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyView: UILabel!
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    let itemsPerRow: CGFloat = 3
    var queryString: String?
    var items : [Picture]?
    var productIndexPath:[AnyHashable:Any]  =  [:]
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Photos"
        self.navigationItem.searchController = searchController
        activityIndicator.hidesWhenStopped = true
        // Do any additional setup after loading the view.
        if let presenter = self.presenter {
            presenter.reloadData()
            activityIndicator.startAnimating()
        }
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Navigation.PhotoPreviewIdentifier {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                let detailView = segue.destination as? PhotoPreviewViewController
                detailView?.item = self.items?[indexPath.item]
            }
        }
    }

    // MARK: - Custom methods
    func loadImages(item : Picture) {
        ImageCache.publicCache.load(url: item.pictureUrls.thumb as NSURL, item: item) { (fetchedItem, image) in
            let position = self.items?.firstIndex(of: item)
            let indexpath = IndexPath(item: position ?? 0, section: 0)
            if let tableCell = self.collectionView.cellForItem(at: indexpath) as? PhotoCell {
                tableCell.imageView.image = image
            }

        }
    }

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "search.placeholder"
        searchController.searchBar.autocapitalizationType = .none
        return searchController
    }()

}

// MARK: - UISearchControllerDelegate
extension GridViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        self.collectionView.scrollsToTop = true
        if let query = self.queryString, query.count > 0 {
            self.queryString = nil
            if let presenter = self.presenter {
                presenter.dismissSearchController()
            }
        }
    }
    
}

// MARK: - UISearchBarDelegate
extension GridViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        self.queryString = text
        if let _ = self.presenter, let query = self.queryString {
            self.presenter?.searchedPhotos.removeAll()
            self.presenter?.searchItem(text:query,isStart: true)
        }
        self.activityIndicator.startAnimating()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard self.queryString != nil && searchText.isEmpty else { return }
        self.queryString = nil
        if let presenter = self.presenter {
            presenter.dismissSearchController()
        }
    }
}

// MARK: - PhotoGridViewPreseneterOuput
extension GridViewController: PhotoGridViewPreseneterOuput {
    func fetchDidComplete(withPictures: [Picture]) {
        self.items = withPictures
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    func fetchFailure(withError: Error) {
        DispatchQueue.main.async {
        if self.items == nil || self.items?.count == 0 {
            self.activityIndicator.stopAnimating()
            let errorAlert : UIAlertController = UIAlertController(title: "Oops!", message: "Looks like there is problem with your network.", preferredStyle: UIAlertController.Style.alert)
            let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel) { ACTION -> Void in
            }
            errorAlert.addAction(okAction)
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
    }
}


