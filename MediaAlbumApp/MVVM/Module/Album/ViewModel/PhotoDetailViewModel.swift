//
//  PhotoDetailViewModel.swift
//  MediaAlbumApp
//
//  Created by APPLE on 16/05/21.
//

import Foundation
struct PhotoDetailViewModel {
    
    let photoDM : PhotoDM
    let photoURL : Bind<URL?>

    init(photoDM : PhotoDM) {
        self.photoDM = photoDM
        self.photoURL = Bind(photoDM.urlValue)
    }
    
    //-----------------------------------------------------
    
    //-----------------------------------------------------
}
