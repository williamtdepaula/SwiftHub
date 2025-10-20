//
//  PullRequestRemoteDataSourceImpl.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

final class PullRequestRemoteDataSourceImpl: PullRequestsRemoteDataSourceProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func fetchPullRequests(repositoryOwner: String, repositoryName: String, page: Int) async throws -> [PullRequestDTO] {
        try await network.request(PullRequestsAPI.pullRequests(owner: repositoryOwner, repository: repositoryName, page: page), keyPath: nil)
    }
}

#if DEBUG
final class FakePullRequestRemoteDataSourceImpl: PullRequestsRemoteDataSourceProtocol {
    func fetchPullRequests(repositoryOwner: String, repositoryName: String, page: Int) async throws -> [PullRequestDTO] {
        [PullRequestDTO.mock]
    }
}
#endif
