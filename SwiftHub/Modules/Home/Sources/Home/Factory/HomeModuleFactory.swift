//
//  HomeModuleFactory.swift
//  Home
//
//  Created by Willian de Paula on 17/10/25.
//

import UIKit
import Core

public class HomeModuleFactory: HomeFactory {
    public init() {}
    
    public func makeHomeViewController() -> UIViewController {
        let viewModel = HomeViewModel()
        return HomeViewController(viewModel: viewModel)
    }
}
