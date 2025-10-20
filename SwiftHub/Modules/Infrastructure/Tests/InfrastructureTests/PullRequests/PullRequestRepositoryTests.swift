//
//  PullRequestRepositoryTests.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Testing

@testable import Infrastructure

struct PullRequestRepositoryTest {
    @Test("Get pullRequests list from REPOSITORY successfully") func isGettingPullRequests() async throws {
        let remoteDataSource = FakePullRequestRemoteDataSourceImpl()
        
        let repository = PullRequestRepositoryImpl(remoteDataSource: remoteDataSource)
        
        let pullRequests = try await repository.getPullRequests(owner: "Something", repository: "SomethingElse", page: 1)
        
        #expect(pullRequests.count > 0)
    }
}
