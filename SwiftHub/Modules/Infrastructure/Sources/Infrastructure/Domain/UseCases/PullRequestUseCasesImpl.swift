//
//  PullRequestUseCasesImpl.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Core

final class PullRequestUseCasesImpl: PullRequestUseCasesProtocol {
    private let repository: PullRequestRepositoryProtocol
    
    init(repository: PullRequestRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPullRequests(ownerName: String, repositoryName: String, page: Int) async throws -> [PullRequest] {
        try await repository.getPullRequests(owner: ownerName, repository: repositoryName, page: page)
    }
}
