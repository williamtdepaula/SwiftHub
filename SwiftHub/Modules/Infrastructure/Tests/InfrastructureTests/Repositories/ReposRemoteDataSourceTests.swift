//
//  ReposRemoteDataSourceTests.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

import Testing

@testable import Infrastructure

struct ReposRemoteDataSourceTest {
    @Test("Get repositories from DATASOURCE successfully") func isGettingRepositories() async throws {
        let fakeRepositories = [RepositoryDTO.mock]
        let network = FakeNetwork(response: fakeRepositories)
        let dataSource = ReposRemoteDataSourceImpl(network: network)
        
        let repositoriesDTO = try await dataSource.fetchRepositories(page: 1)
        
        #expect(repositoriesDTO.count > 0)
        #expect(repositoriesDTO.first?.id == fakeRepositories.first?.id)
    }
}
