//
//  View+Extensions.swift
//  Core
//
//  Created by Willian de Paula on 18/10/25.
//

import UIKit

extension UIView {
    @discardableResult
    public func useConstraints() -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
