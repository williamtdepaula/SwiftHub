//
//  RepositoryUseCasesFactory.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Core

public final class RepositoryUseCasesFactory: RepositoryUseCaseFactory {
    public init() {}
    
    public func make() -> ReposUseCasesProtocol {
        let repoDataSource = ReposRemoteDataSourceImpl(network: Network())
        let repository = ReposRepositoryImpl(remoteDataSource: repoDataSource)
        return ReposUseCasesImpl(reposRepository: repository)
    }
}
