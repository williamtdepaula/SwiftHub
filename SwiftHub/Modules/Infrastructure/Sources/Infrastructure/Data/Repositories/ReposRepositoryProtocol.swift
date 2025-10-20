//
//  RepositoryRespositoriesProtocol.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

import Core

protocol ReposRepositoryProtocol: Sendable {
    func getRepositories(page: Int) async throws -> [Repository]
}
