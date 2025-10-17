//
//  RepositoryRemoteDataSource.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

protocol ReposRemoteDataSourceProtocol {
    func fetchRepositories(page: Int) async throws -> [RepositoryDTO]
}
