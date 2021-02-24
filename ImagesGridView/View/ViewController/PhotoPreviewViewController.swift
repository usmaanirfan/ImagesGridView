//
//  PhotoPreviewViewController.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 22/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation
import UIKit
class PhotoPreviewViewController: UIViewController {

    @IBOutlet weak var regularImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var item : Picture?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = item?.user.name
        activityIndicator.hidesWhenStopped = true
        if let photo = self.item {
            if let image = ImageCache.publicCache.image(url: photo.pictureUrls.regular as NSURL)  {
                self.regularImage.image = image
            } else {
                activityIndicator.startAnimating()
                self.loadImages(item: photo)
            }
        }
    }

    func loadImages(item : Picture) {
        ImageCache.publicCache.load(url: item.pictureUrls.regular as NSURL, item: item) { (fetchedItem, image) in
            self.regularImage.image = image
            self.activityIndicator.stopAnimating()
        }
    }

}
