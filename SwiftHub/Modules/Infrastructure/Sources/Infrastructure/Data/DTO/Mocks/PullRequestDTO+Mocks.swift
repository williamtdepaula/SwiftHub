//
//  PullRequestDTO+MOcks.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

#if DEBUG
extension PullRequestDTO {
    static let mocks: [Self] = [.mockMerged, .mockClosed, .mockOpen]
    
    static let mockMerged: Self = PullRequestDTO(
        id: 1,
        title: "My PullRequest",
        body: "Description about resolve something",
        created_at: "2011-01-26T19:01:12Z",
        merged_at: "2025-09-29T13:15:43Z",
        html_url: "https://github.com",
        state: .closed,
        user: .mock
    )
    static let mockClosed: Self = PullRequestDTO(
        id: 1,
        title: "My PullRequest",
        body: "Description about resolve something",
        created_at: "2011-01-26T19:01:12Z",
        merged_at: nil,
        html_url: "https://github.com",
        state: .closed,
        user: .mock
    )
    static let mockOpen: Self = PullRequestDTO(
        id: 1,
        title: "My PullRequest",
        body: "Description about resolve something",
        created_at: "2011-01-26T19:01:12Z",
        merged_at: nil,
        html_url: "https://github.com",
        state: .open,
        user: .mock
    )
}
#endif
