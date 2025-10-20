//
//  PullRequestUseCasesProtocol.swift
//  Core
//
//  Created by Willian de Paula on 20/10/25.
//

public protocol PullRequestUseCasesProtocol: Sendable {
    func getPullRequests(ownerName: String, repositoryName: String, page: Int) async throws -> [PullRequest]        
}
