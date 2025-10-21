//
//  PullRequestsCoordinating.swift
//  Core
//
//  Created by Willian de Paula on 20/10/25.
//

public protocol PullRequestsCoordinating: AnyObject {
    func onPressPullRequest(_ pullRequest: PullRequest) -> Void
    func onPressToBack() -> Void
}
