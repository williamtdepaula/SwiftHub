//
//  PullRequestUseCasesImpl.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Core

public final class PullRequestUseCasesFactoryImpl: PullRequestUseCaseFactory {
    public init() {}
    
    public func make() -> PullRequestUseCasesProtocol {
        let repoDataSource = PullRequestRemoteDataSourceImpl(network: Network())
        let repository = PullRequestRepositoryImpl(remoteDataSource: repoDataSource)
        return PullRequestUseCasesImpl(repository: repository)
    }
}

final class PullRequestUseCasesImpl: PullRequestUseCasesProtocol {
    private let repository: PullRequestRepositoryProtocol
    
    init(repository: PullRequestRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPullRequests(ownerName: String, repositoryName: String, page: Int) async throws -> [PullRequest] {
        try await repository.getPullRequests(owner: ownerName, repository: repositoryName, page: page)
    }
}
