//
//  CodeView.swift
//  Core
//
//  Created by Willian de Paula on 18/10/25.
//

import Foundation

@MainActor
public protocol CodeView {
    func setupViewHierarchy()
    func setupConstraints()
    func setupAddtionalConfigs()
}

extension CodeView {
    public func setupView() {
        setupViewHierarchy()
        setupConstraints()
        setupAddtionalConfigs()
    }
}
