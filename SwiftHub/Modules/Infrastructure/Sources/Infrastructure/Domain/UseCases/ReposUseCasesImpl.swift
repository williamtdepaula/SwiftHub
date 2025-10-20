//
//  RepositoriesUseCasesImpl.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

import Core

public final class ReposUseCasesFactory: RepositoryUseCaseFactory {
    public init() {}
    
    public func make() -> ReposUseCasesProtocol {
        let repoDataSource = ReposRemoteDataSourceImpl(network: Network())
        let repository = ReposRepositoryImpl(remoteDataSource: repoDataSource)
        return ReposUseCasesImpl(reposRepository: repository)
    }
}

final class ReposUseCasesImpl: ReposUseCasesProtocol {
    
    private let reposRepository: ReposRepositoryProtocol
    
    init(reposRepository: ReposRepositoryProtocol) {
        self.reposRepository = reposRepository
    }
    
    func getRepositories(page: Int) async throws -> [Repository] {
        try await reposRepository.getRepositories(page: page)
    }
}
