//
//  ActivityIndicator+Extensions.swift
//  Core
//
//  Created by Willian de Paula on 18/10/25.
//

import UIKit

extension UIActivityIndicatorView {
    public func play() {
        self.isHidden = false
        self.startAnimating()
    }
    
    public func pause() {
        self.isHidden = true
        self.stopAnimating()
    }
}
