//
//  HomeCoordinator.swift
//  SwiftHub
//
//  Created by Willian de Paula on 20/10/25.
//

import Core
import UIKit
import Swinject

public class HomeCoordinator: BaseCoordinator {
    override public func start() {
        guard let homeFactory = InjecterContainer.shared.resolve(HomeFactory.self) else { return }
        
        let homeVC = homeFactory.makeHomeViewController(coordinator: self)
        
        navigationController.setViewControllers([homeVC], animated: true)
    }
}

extension HomeCoordinator: HomeCoordinating {
    public func onPressRepository(ownerName: String, repositoryName: String) {
        let prCoordinator = PullRequestsCoordinator(
            navigationController: navigationController,
            ownerName: ownerName,
            repositoryName: repositoryName
        )
        
        prCoordinator.parent = self
        
        addChild(prCoordinator)
        
        prCoordinator.start()
    }
}
