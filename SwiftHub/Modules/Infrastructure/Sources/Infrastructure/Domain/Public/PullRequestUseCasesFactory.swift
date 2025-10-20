//
//  PullRequestUseCasesFactory.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Core

public final class PullRequestUseCasesFactoryImpl: PullRequestUseCaseFactory {
    public init() {}
    
    public func make() -> PullRequestUseCasesProtocol {
        let repoDataSource = PullRequestRemoteDataSourceImpl(network: Network())
        let repository = PullRequestRepositoryImpl(remoteDataSource: repoDataSource)
        return PullRequestUseCasesImpl(repository: repository)
    }
}
