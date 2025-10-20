//
//  PullRequestRepositoryImpl.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Core

final class PullRequestRepositoryImpl: PullRequestRepositoryProtocol {
    private let remoteDataSource: PullRequestsRemoteDataSourceProtocol
    
    init(remoteDataSource: PullRequestsRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getPullRequests(owner: String, repository: String, page: Int) async throws -> [PullRequest] {
        let result = try await remoteDataSource.fetchPullRequests(repositoryOwner: owner, repositoryName: repository, page: page)
        return result.map({ $0.toModel() })
    }
}

// MARK: MOCKS
#if DEBUG
final class FakePullRequestRepositoryImpl: PullRequestRepositoryProtocol {
    
    let pullRequests: [PullRequest]
    
    init(pullRequests: [PullRequest]) {
        self.pullRequests = pullRequests
    }
    
    func getPullRequests(owner: String, repository: String, page: Int) async throws -> [Core.PullRequest] {
        pullRequests
    }
    
}
#endif
