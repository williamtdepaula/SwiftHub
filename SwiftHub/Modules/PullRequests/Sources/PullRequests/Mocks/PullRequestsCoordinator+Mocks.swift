//
//  PullRequestsCoordinator+Mocks.swift
//  PullRequests
//
//  Created by Willian de Paula on 20/10/25.
//

import Core

#if DEBUG
final class FakeHomeCoordinator: PullRequestsCoordinating {
    
    var onPressPullRequestCalled = false
    var onPressToBackCalled = false
    
    func onPressPullRequest(_ pullRequest: Core.PullRequest) {
        onPressPullRequestCalled = true
    }
    
    func onPressToBack() {
        onPressToBackCalled = true
    }
    
}
#endif
