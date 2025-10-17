//
//  ReposRepositoryTest.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

import Testing

@testable import Infrastructure

struct ReposRespositoryTest {
    @Test func isGettingRepositories() async throws {
        let dataSource = FakeReposRemoteDataSourceImpl()
        let repository = ReposRepositoryImpl(remoteDataSource: dataSource)
        
        let repositories = try await repository.getRepositories(page: 1)
        
        #expect(repositories.count > 0)
    }
}
