//
//  PullRequestsCoordinator.swift
//  SwiftHub
//
//  Created by Willian de Paula on 20/10/25.
//

import UIKit
import Core
import Swinject

public class PullRequestsCoordinator: BaseCoordinator {
    let ownerName: String
    let repositoryName: String
    
    public init(navigationController: UINavigationController, ownerName: String, repositoryName: String) {
        self.ownerName = ownerName
        self.repositoryName = repositoryName
        super.init(navigationController: navigationController)
    }
    
    override public func start() {
        guard
            let pullRequestsFactory = InjecterContainer.shared.resolve(PullRequestsFactory.self),
            let pullRequestsUseCasesFactory = InjecterContainer.shared.resolve(PullRequestUseCaseFactory.self)
        else { return }
        
        let vc = pullRequestsFactory.makeViewController(
            coordinator: self,
            pullRequestUseCases: pullRequestsUseCasesFactory.make(),
            ownerName: ownerName,
            repositoryName: repositoryName
        )
        
        navigationController.pushViewController(vc, animated: true)
    }
}

extension PullRequestsCoordinator: PullRequestsCoordinating {
    public func onPressPullRequest(_ pullRequest: Core.PullRequest) {
        
    }
    
    public func onPressToBack() {
        parent?.removeChild(self)
        navigationController.popViewController(animated: true)
    }
}
