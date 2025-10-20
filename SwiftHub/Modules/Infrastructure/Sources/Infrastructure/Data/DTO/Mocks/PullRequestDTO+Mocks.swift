//
//  PullRequestDTO+MOcks.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

#if DEBUG
extension PullRequestDTO {
    static let mock: Self = PullRequestDTO(
        id: 1,
        title: "My PullRequest",
        body: "Description about resolve something",
        created_at: "2011-01-26T19:01:12Z",
        user: .mock
    )
}
#endif
