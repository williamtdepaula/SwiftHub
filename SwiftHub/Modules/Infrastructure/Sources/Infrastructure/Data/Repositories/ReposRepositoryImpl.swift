//
//  RepositoriesRepositoryImpl.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

final class ReposRepositoryImpl: ReposRepositoryProtocol {
    let remoteDataSource: ReposRemoteDataSourceProtocol
    
    init(remoteDataSource: ReposRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getRepositories(page: Int) async throws -> [Repository] {
        let repositories = try await remoteDataSource.fetchRepositories(page: page)
        
        return repositories.map({ $0.toModel() })
    }
}


final class FakeReposRepositoryImpl: ReposRepositoryProtocol {
    let repositories: [Repository]
    
    init(repositories: [Repository]) {
        self.repositories = repositories
    }
    
    func getRepositories(page: Int) async throws -> [Repository] {
        repositories
    }
}
