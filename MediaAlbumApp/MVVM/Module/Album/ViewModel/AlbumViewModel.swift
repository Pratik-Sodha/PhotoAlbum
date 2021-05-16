//
//  AlbumViewModel.swift
//  MediaAlbumApp
//
//  Created by APPLE on 15/05/21.
//

import Foundation
struct AlbumViewModel {
    
    let networkManager : NetworkManager
    init(networkManager : NetworkManager = NetworkManager()) {
        
        self.networkManager = networkManager

    }

    //-----------------------------------------------------
    var datasource = Bind<[AlbumDM]>([])
    var apiResponseFailure : Bind<Error?> = Bind(nil)
    //-----------------------------------------------------
  
    //MARK:- Network call
    func loadAlbums(completion block : ((Bool,Error?) ->())? = nil) {
        networkManager.fetchAlbums { (result) in
            switch result {
            case .success(let albums):
                datasource.value = albums
                self.apiResponseFailure.value = nil
                block?(true,nil)
            case .failure(let error):
                self.apiResponseFailure.value = error
                block?(false,error)
            }
        }
    }
}
