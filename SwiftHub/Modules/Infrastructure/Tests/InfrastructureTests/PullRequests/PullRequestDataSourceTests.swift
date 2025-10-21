//
//  PullRequestDataSourceTest.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Testing

@testable import Infrastructure

struct PullRequestRemoteDataSourceTest {
    @Test("Get pull requests from DATASOURCE successfully") func isGettingPullRequests() async throws {
        let fakePullRequests = PullRequestDTO.mocks
        let network = FakeNetwork(response: fakePullRequests)
        let dataSource = PullRequestRemoteDataSourceImpl(network: network)
        
        let pullRequestsDTO = try await dataSource.fetchPullRequests(repositoryOwner: "Something", repositoryName: "SomethingElse", page: 1)
        
        #expect(pullRequestsDTO.count > 0)
        #expect(pullRequestsDTO.first?.id == fakePullRequests.first?.id)
    }
}
