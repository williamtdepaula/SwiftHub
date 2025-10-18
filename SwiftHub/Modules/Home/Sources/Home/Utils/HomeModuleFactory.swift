//
//  HomeModuleFactory.swift
//  Home
//
//  Created by Willian de Paula on 17/10/25.
//

import UIKit
import Core
import Infrastructure

public class HomeModuleFactory: HomeFactory {
    public init() {}
    
    public func makeHomeViewController() -> UIViewController {
        guard
            let repository = InjecterContainer.shared.resolve(ReposUseCasesProtocol.self)
        else { return UIViewController() }
        
        let viewModel = HomeViewModel(repositoryUseCase: repository)
        return HomeViewController(viewModel: viewModel)
    }
}
