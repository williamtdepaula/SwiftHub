//
//  PullRequestsViewModel.swift
//  PullRequests
//
//  Created by Willian de Paula on 20/10/25.
//

import Core

@MainActor
final class PullRequestsViewModel {
    
    private weak var coordinator: PullRequestsCoordinating?
    
    let repositoryName: String
    
    init(coordinator: PullRequestsCoordinating, ownerName: String, repositoryName: String) {
        self.repositoryName = repositoryName
        self.coordinator = coordinator
    }
    
}

// MARK: - Public funcs
extension PullRequestsViewModel {
    func onPressBack() {
        coordinator?.onPressToBack()
    }
}
