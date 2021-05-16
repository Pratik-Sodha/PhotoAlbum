//
//  PhotoPageViewModel.swift
//  MediaAlbumApp
//
//  Created by APPLE on 16/05/21.
//

import Foundation

struct PhotoPageViewModel {
    
    let photos : [PhotoDM]
    var currentPhoto : PhotoDM
    
    mutating func updateCurrentIndex(index : Int) {
        currentPhoto = photos[index]
    }
    var index : Int? {
        photos.firstIndex { (model) -> Bool in
            model.id == currentPhoto.id
        }
    }
    
    func getIndex(photoDM : PhotoDM) -> Int? {
        photos.firstIndex { (itterativeModel) -> Bool in
            itterativeModel.id == photoDM.id
        }
    }
}
