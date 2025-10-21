//
//  RepositoryUseCase+Mocks.swift
//  Home
//
//  Created by Willian de Paula on 18/10/25.
//

import Infrastructure
import Core

#if DEBUG
final class ReposUseCasesMock: ReposUseCasesProtocol {
    enum Cases {
        case success
        case error
        case errorOn(page: Int)
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
        case .errorOn(let maxPage):
            if page == maxPage {
                throw SwiftHubError.generic
            }
            
            return Repository.mocks
        }
    }
}
#endif
