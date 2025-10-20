//
//  PullRequestsRemoteDataSourceProtocol.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

protocol PullRequestsRemoteDataSourceProtocol: Sendable {
    func fetchPullRequests(repositoryOwner: String, repositoryName: String, page: Int) async throws -> [PullRequestDTO]
}
