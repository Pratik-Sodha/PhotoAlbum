//
//  ImageListViewModel.swift
//  MediaAlbumApp
//
//  Created by APPLE on 15/05/21.
//

import Foundation

struct  ImageListViewModel {

    let alumbDM : AlbumDM
    let networkManager : NetworkManager
    init(album : AlbumDM,
        networkManager : NetworkManager = NetworkManager()) {
        
        self.networkManager = networkManager
        self.alumbDM = album
    }
    
    //-----------------------------------------------------
    var datasource = Bind<[PhotoDM]>([])
    var apiResponseFailure : Bind<Error?> = Bind(nil)
    //-----------------------------------------------------
    
    func loadPhotos(completion block : ((Bool,Error?) ->())? = nil) {

        networkManager.fetchPhotos(albumId: alumbDM.id, completion: { (result) in
            switch result {
            case .success(let albums):
                datasource.value = albums
                self.apiResponseFailure.value = nil
                block?(true,nil)
            case .failure(let error):
                self.apiResponseFailure.value = error
                block?(false,error)
            }
        })
    }
}
