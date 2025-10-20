//
//  RepositoryMapper.swift
//  Home
//
//  Created by Willian de Paula on 18/10/25.
//

import Core
import Foundation

struct RepositoryPresentationMapper {
    static func map(entity: Repository) -> RepositoryPresentation {
        return RepositoryPresentation(
            id: entity.id,
            title: entity.name,
            starsCount: entity.starsCount,
            forksCount: entity.forksCount,
            description: entity.description,
            owenerUserName: entity.owner.userName,
            owenerAvatarUrl: URL(string: entity.owner.avatarStringUrl)
        )
    }
}
