//
//  RepositoryDTO.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

import Core

struct RepositoryDTO: Codable {
    let id: Int
    let name: String
    let stargazers_count: Int
    let forks_count: Int
    let description: String?
    let owner: OwnerDTO
}

extension RepositoryDTO {
    func toModel() -> Repository {
        return Repository(
            id: id,
            name: name,
            starsCount: stargazers_count,
            forksCount: forks_count,
            description: description,
            owner: owner.toModel()
        )
    }
}
