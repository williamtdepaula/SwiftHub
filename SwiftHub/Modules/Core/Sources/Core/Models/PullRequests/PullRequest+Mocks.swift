//
//  PullRequest+Mocks.swift
//  Core
//
//  Created by Willian de Paula on 20/10/25.
//

#if DEBUG
extension PullRequest {
    public static let mocks: [PullRequest] = [
        mock01,
        mock02,
        mock03,
    ]
    
    public static let mock01: PullRequest = PullRequest(id: 0, title: "Some PR", body: "A description about this PR", createdAt: "2011-01-26T19:01:12Z", owner: .mock01)
    public static let mock02: PullRequest = PullRequest(id: 0, title: "Other PR", body: "A description about this PR", createdAt: "2011-01-26T19:01:12Z", owner: .mock02)
    public static let mock03: PullRequest = PullRequest(id: 0, title: "PR to resolve something", body: "A description about this PR", createdAt: "2011-01-26T19:01:12Z", owner: .mock03)
}
#endif
