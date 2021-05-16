//
//  LoadingController.swift
//  MediaAlbumApp
//
//  Created by APPLE on 15/05/21.
//

import UIKit

class LoadingController: UIViewController {

    lazy var indicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(indicator)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        indicator.startAnimating()
    }

    static func loadController() -> LoadingController {
        LoadingController()
    }
}
