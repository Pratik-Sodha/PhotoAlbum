//
//  Router.swift
//  MediaAlbumApp
//
//  Created by APPLE on 14/05/21.
//

import Foundation
import UIKit
class Router  {

    enum RouterState {
        case albumLisitng
    }
    
    private let window : UIWindow

    init?(window : UIWindow?) {
        guard let window = window else {
            fatalError("Window not found")
            return nil
        }
        self.window = window
    }
    
    
   private var routerState : RouterState {
        return .albumLisitng
    }
}
extension Router {
    
    func switchToAlbumListingScreen() {


        let controller = AlbumListController.loadController()
        let navigationController  = UINavigationController(launchingController: controller)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func switchToRouterScreen() {
        switch self.routerState {
        case .albumLisitng:
            switchToAlbumListingScreen()

        }
    }
}
