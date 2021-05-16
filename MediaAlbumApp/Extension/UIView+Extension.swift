//
//  UIView+Extension.swift
//  MediaAlbumApp
//
//  Created by APPLE on 14/05/21.
//

import Foundation
import UIKit

//MARK:- Nib helper
extension UIView {
    class var nibName : String {
        return String(describing: self)
    }
    class func nib() -> UINib {
        UINib(nibName: nibName, bundle: nil)
    }
}


//MARK:- Constraints
extension UIView {
    func edgeToSuperView() {
        
        guard let _superView = superview else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: _superView.topAnchor),
            self.bottomAnchor.constraint(equalTo: _superView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: _superView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: _superView.trailingAnchor)
        ])
    }
}
