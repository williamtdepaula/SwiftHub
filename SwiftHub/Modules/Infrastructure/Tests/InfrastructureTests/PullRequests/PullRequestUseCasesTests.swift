//
//  PullRequestUseCasesTests.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Testing

import Core
@testable import Infrastructure

struct PullRequestUseCasesTest {
    @Test("Get pullRequests list from an useCase successfully") func isGettingPullRequests() async throws {
        let repository = FakePullRequestRepositoryImpl(pullRequests: PullRequest.mocks)
        
        let useCase = PullRequestUseCasesImpl(repository: repository)
        
        let pullRequests = try await useCase.getPullRequests(ownerName: "Something", repositoryName: "SomethingElse", page: 1)
        
        #expect(pullRequests.count == PullRequest.mocks.count)
    }
}
