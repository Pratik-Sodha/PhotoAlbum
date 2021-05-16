//
//  BaseController.swift
//  MediaAlbumApp
//
//  Created by APPLE on 14/05/21.
//

import UIKit

class BaseController: UIViewController {

}

//-----------------------------------------------------
//MARK:- Loader
extension BaseController {
    func showLoader() {
        let controller = LoadingController.loadController()
        controller.modalPresentationStyle = .overCurrentContext
        present(controller, animated: false, completion: nil)
    }
    
    func stopLoader() {
        dismiss(animated: false, completion: nil)
    }
}
