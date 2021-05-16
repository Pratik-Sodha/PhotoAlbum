//
//  UINavigationController+Extension.swift
//  MediaAlbumApp
//
//  Created by APPLE on 14/05/21.
//

import Foundation
import UIKit

extension UINavigationController {
    
    convenience init(launchingController controller : UIViewController) {
        self.init(rootViewController: controller)
    }
    
    convenience init(presentController controller : UIViewController) {
        self.init(rootViewController: controller)
    }
}
