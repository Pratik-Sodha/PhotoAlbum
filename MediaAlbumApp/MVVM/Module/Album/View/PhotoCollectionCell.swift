//
//  PhotoCollectionCell.swift
//  MediaAlbumApp
//
//  Created by APPLE on 15/05/21.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var imageView : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
    }

    var photo : PhotoDM! {
        didSet {
            imageView.set(url: photo.thumbnailUrlValue)
        }
    }
}
