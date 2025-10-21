//
//  PullRequestUseCases+Mocks.swift
//  PullRequests
//
//  Created by Willian de Paula on 20/10/25.
//

import Infrastructure
import Core

#if DEBUG
final class FakePullRequestUseCases: PullRequestUseCasesProtocol {
    
    enum Cases {
        case success
        case error
        case errorOn(page: Int)
    }
    
    let theCase: Cases
    
    init(theCase: Cases) {
        self.theCase = theCase
    }
    
    func getPullRequests(ownerName: String, repositoryName: String, page: Int) async throws -> [PullRequest] {
        switch theCase {
        case .error:
            throw SwiftHubError.generic
        case .success:
            return PullRequest.mocks
        case .errorOn(let maxPage):
            if page == maxPage {
                throw SwiftHubError.generic
            }
            
            return PullRequest.mocks
        }
    }
}
#endif
