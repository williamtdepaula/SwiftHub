//
//  PullRequestRepositoryProtocol.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Core

protocol PullRequestRepositoryProtocol: Sendable {
    func getPullRequests(owner: String, repository: String, page: Int) async throws -> [PullRequest]
}
