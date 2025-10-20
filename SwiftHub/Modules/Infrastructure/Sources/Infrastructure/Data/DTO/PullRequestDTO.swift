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
    let owner: OwnerDTO
    
    public init(id: Int, title: String, body: String, created_at: String, owner: OwnerDTO) {
        self.id = id
        self.title = title
        self.body = body
        self.created_at = created_at
        self.owner = owner
    }
}

extension PullRequestDTO {
    func toModel() -> PullRequest {
        .init(
            id: id,
            title: title,
            body: body,
            createdAt: created_at,
            owner: owner.toModel()
        )
    }
}
