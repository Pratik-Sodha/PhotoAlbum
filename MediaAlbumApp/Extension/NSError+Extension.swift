//
//  NSError+Extension.swift
//  MediaAlbumApp
//
//  Created by APPLE on 14/05/21.
//

import Foundation
extension NSError {
    
    convenience init(title : String?, code : Int = 0, message : String) {
        var userInfo : [String : String] = [:]
        
        userInfo[NSLocalizedRecoverySuggestionErrorKey] = title
        userInfo[NSLocalizedDescriptionKey] = message
        self.init(domain : "MediaAlbum", code : code, userInfo : userInfo)
    }

    convenience init(message : String) {
        self.init(title : nil, message : message)
    }
    
}
