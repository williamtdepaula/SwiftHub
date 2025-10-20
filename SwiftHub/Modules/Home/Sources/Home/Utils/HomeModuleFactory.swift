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
        guard
            let repository = InjecterContainer.shared.resolve(RepositoryUseCaseFactory.self)
        else { return UIViewController() }
        
        let viewModel = HomeViewModel(repositoryUseCase: repository.make())
        return HomeViewController(viewModel: viewModel)
    }
}
