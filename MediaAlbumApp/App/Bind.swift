//
//  Bind.swift
//  MediaAlbumApp
//
//  Created by APPLE on 15/05/21.
//

import Foundation
class Bind<T> {
    typealias Listener = (T) -> ()
    
    var value: T {
        didSet {
            listener?(value)
        }
    }

    var listener: Listener?
    
    // MARK:- initializers for the binder
    init(_ value: T) {
        self.value = value
    }
    
    // MARK:- functions for the binder
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
