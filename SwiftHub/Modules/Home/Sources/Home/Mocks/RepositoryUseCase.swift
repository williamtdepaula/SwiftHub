//
//  RepositoryUseCase.swift
//  Home
//
//  Created by Willian de Paula on 18/10/25.
//

import Infrastructure
import Core

final class ReposUseCasesMock: ReposUseCasesProtocol {
    enum Cases {
        case success
        case error
    }
    
    let theCase: Cases
    
    init(theCase: Cases) {
        self.theCase = theCase
    }
    
    func getRepositories(page: Int) async throws -> [Repository] {
        switch theCase {
        case .error:
            throw SwiftHubError.generic
        case .success:
            return Repository.mocks
        }
    }
}
