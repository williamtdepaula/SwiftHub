//
//  OwnerDTO.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Core

struct OwnerDTO: Codable {
    let id: Int
    let login: String
    let avatar_url: String
}

extension OwnerDTO {
    func toModel() -> Owner {
        return Owner(
            id: id,
            userName: login,
            avatarStringUrl: avatar_url
        )
    }
}
