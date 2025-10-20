//
//  RepositoriesUseCasesTest.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

import Testing

import Core
@testable import Infrastructure

struct RepositoriesUseCasesTest {
    @Test("Get repositories from an useCase successfully") func isGettingRepositories() async throws {
        let repository = FakeReposRepositoryImpl(repositories: Repository.mocks)
        
        let useCase = ReposUseCasesImpl(reposRepository: repository)
        
        let repositories = try await useCase.getRepositories(page: 1)
        
        #expect(repositories.count == Repository.mocks.count)
    }
}
