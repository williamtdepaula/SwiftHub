//
//  ReposUseCasesProtocol.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

protocol ReposUseCasesProtocol {
    func getRepositories(page: Int) async throws -> [Repository]
}
