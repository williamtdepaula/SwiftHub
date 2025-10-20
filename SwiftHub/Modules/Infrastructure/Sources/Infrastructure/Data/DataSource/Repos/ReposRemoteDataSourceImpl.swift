//
//  RepositoryRemoteDataSourceImpl.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

final class ReposRemoteDataSourceImpl: ReposRemoteDataSourceProtocol {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func fetchRepositories(page: Int) async throws -> [RepositoryDTO] {
        return try await network.request(RepositoryAPI.mostPopularSwiftRepositories(page: page), keyPath: "items")
    }
}

#if DEBUG
// MARK: Mocks
final class FakeReposRemoteDataSourceImpl: ReposRemoteDataSourceProtocol {
    func fetchRepositories(page: Int) async throws -> [RepositoryDTO] {
        [RepositoryDTO.mock]
    }
}
#endif
