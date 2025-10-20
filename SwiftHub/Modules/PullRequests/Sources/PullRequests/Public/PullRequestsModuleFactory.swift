//
//  PullRequestsModuleFactory.swift
//  PullRequests
//
//  Created by Willian de Paula on 20/10/25.
//

import UIKit
import Core

public final class PullRequestsViewControllerFactory: PullRequestsFactory {
    public init() {}
    
    public func makeViewController(coordinator: PullRequestsCoordinating, ownerName: String, repositoryName: String) -> UIViewController {
        let viewModel = PullRequestsViewModel(coordinator: coordinator, ownerName: ownerName, repositoryName: repositoryName)
        let viewController = PullRequestsViewController(viewModel: viewModel)
        return viewController
    }
}
