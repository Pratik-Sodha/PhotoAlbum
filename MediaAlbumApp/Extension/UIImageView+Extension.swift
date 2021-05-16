//
//  UIImageView+Extension.swift
//  MediaAlbumApp
//
//  Created by APPLE on 16/05/21.
//

import Foundation
import AlamofireImage

extension UIImageView {
    
    func set(url : URL?,
             placeHolderImage : UIImage? = UIImage(systemName: "photo")) {
        guard let url = url else {
            self.image = placeHolderImage
            return
        }
        
        self.af.setImage(withURL: url,
                         placeholderImage: placeHolderImage)
    }
    
}
