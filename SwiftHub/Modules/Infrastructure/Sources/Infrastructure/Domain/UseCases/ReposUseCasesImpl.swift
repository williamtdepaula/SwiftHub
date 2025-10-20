//
//  RepositoriesUseCasesImpl.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

import Core

final class ReposUseCasesImpl: ReposUseCasesProtocol {
    
    private let reposRepository: ReposRepositoryProtocol
    
    init(reposRepository: ReposRepositoryProtocol) {
        self.reposRepository = reposRepository
    }
    
    func getRepositories(page: Int) async throws -> [Repository] {
        try await reposRepository.getRepositories(page: page)
    }
}
