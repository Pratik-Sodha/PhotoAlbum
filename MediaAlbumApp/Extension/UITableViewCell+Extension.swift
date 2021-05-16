//
//  UITableViewCell+Extension.swift
//  MediaAlbumApp
//
//  Created by APPLE on 14/05/21.
//

import Foundation
import UIKit
extension UITableViewCell {

    class var cellIdentifier : String {
        return String(describing: self)
    }
}
