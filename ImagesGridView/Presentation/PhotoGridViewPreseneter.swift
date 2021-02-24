//
//  PhotoGridViewPreseneter.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 21/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation


class PhotoGridViewPreseneter : PhotoBusinessLogicUseCaseOutput, SearchPhotoBusinessLogicUseCaseOutPut,GridViewPreseneterInterface {

    var photoGridViewPreseneterOuput: PhotoGridViewPreseneterOuput
    var fetchPhotos: (() -> Void)?
    var searchPhotos: ((String,Bool) -> Void)?
    var photos = [Picture]()
    var searchedPhotos = [Picture]()

    required init(photoGridViewPreseneterOuput: PhotoGridViewPreseneterOuput) {
        self.photoGridViewPreseneterOuput = photoGridViewPreseneterOuput
    }

    func reloadData() {
        fetchPhotos?()
    }

    func searchItem(text : String, isStart : Bool = false) {
        searchPhotos?(text,isStart)
    }

    func didFetch(_ items: [Picture]) {
        self.photos.append(contentsOf: items)
        self.photoGridViewPreseneterOuput.fetchDidComplete(withPictures: self.photos)
    }

    func didGetError(_ errr: Error) {
        self.photoGridViewPreseneterOuput.fetchFailure(withError: errr)
    }

    func didSearch(_ items: [Picture]) {
        self.searchedPhotos.append(contentsOf: items)
        self.photoGridViewPreseneterOuput.fetchDidComplete(withPictures: self.searchedPhotos)
    }

    func didGetSearchError(_ errr: Error) {
        self.photoGridViewPreseneterOuput.fetchFailure(withError: errr)
    }

    func dismissSearchController() {
        self.searchedPhotos.removeAll()
        if self.photos.count > 0 {
            self.photoGridViewPreseneterOuput.fetchDidComplete(withPictures: self.photos)
        }
    }

}
