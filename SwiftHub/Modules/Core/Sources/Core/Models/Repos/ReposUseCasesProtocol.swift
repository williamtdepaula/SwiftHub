//
//  ReposUseCasesProtocol.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

public protocol ReposUseCasesProtocol: Sendable {
    func getRepositories(page: Int) async throws -> [Repository]
}
