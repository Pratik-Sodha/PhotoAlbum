//
//  PhotoDM.swift
//  MediaAlbumApp
//
//  Created by APPLE on 15/05/21.
//

import Foundation
struct PhotoDM : Codable{

    let albumId : Int
    let id : Int
    let title : String
    let url : String
    let thumbnailUrl : String
    
}


extension PhotoDM {
    
    var thumbnailUrlValue : URL? {
        URL(string: thumbnailUrl)
    }
    
    var urlValue : URL? {
        URL(string: url)
    }
}

/*
{
    "albumId": 1,
    "id": 1,
    "title": "accusamus beatae ad facilis cum similique qui sunt",
    "url": "https://via.placeholder.com/600/92c952",
    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
  }
*/
