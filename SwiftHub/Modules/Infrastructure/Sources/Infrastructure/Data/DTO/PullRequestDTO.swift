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
    let body: String
    let created_at: String
    let user: OwnerDTO
    
    public init(id: Int, title: String, body: String, created_at: String, user: OwnerDTO) {
        self.id = id
        self.title = title
        self.body = body
        self.created_at = created_at
        self.user = user
    }
}

extension PullRequestDTO {
    func toModel() -> PullRequest {
        .init(
            id: id,
            title: title,
            body: body,
            createdAt: created_at,
            user: user.toModel()
        )
    }
}
