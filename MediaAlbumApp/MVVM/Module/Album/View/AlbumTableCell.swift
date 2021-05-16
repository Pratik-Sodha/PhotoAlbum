//
//  AlbumTableCell.swift
//  MediaAlbumApp
//
//  Created by APPLE on 15/05/21.
//

import UIKit

class AlbumTableCell: UITableViewCell {

    @IBOutlet private weak var lblTitle : UILabel!
    //-----------------------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.numberOfLines = 0
        lblTitle.textAlignment = .left
    }
    //-----------------------------------------------------
    
    var album : AlbumDM! {
        didSet {
            lblTitle.text = album.title.capitalized
        }
    }

    
}
