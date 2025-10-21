//
//  PullRequestDTO.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Core

struct PullRequestDTO: Codable {
    let id: Int
    let title: String
    let body: String?
    let created_at: String
    let merged_at: String?
    let html_url: String
    let state: PullRequestStateDTO
    let user: OwnerDTO
    
    enum PullRequestStateDTO: String, Codable {
        case open
        case closed
    }
    
    public init(id: Int, title: String, body: String?, created_at: String, merged_at: String?, html_url: String, state: PullRequestStateDTO, user: OwnerDTO) {
        self.id = id
        self.title = title
        self.body = body
        self.created_at = created_at
        self.merged_at = merged_at
        self.html_url = html_url
        self.state = state
        self.user = user
    }
}

extension PullRequestDTO {
    private var mappedState: PullRequest.State {
        if merged_at != nil {
            return .merged
        }
        switch state {
        case .open: return .open
        case .closed: return .closed
        }
    }
    
    func toModel() -> PullRequest {
        return .init(
            id: id,
            title: title,
            body: body,
            createdAt: created_at,
            stringUrl: html_url,
            state: mappedState,
            user: user.toModel()
        )
    }
}
