//
//  RepositoryPresentationMapper.swift
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
            starsCount: Self.formatTotal(entity.starsCount),
            forksCount: Self.formatTotal(entity.forksCount),
            description: entity.description,
            owenerUserName: entity.owner.userName,
            owenerAvatarUrl: URL(string: entity.owner.avatarStringUrl)
        )
    }
    
    private static func formatTotal(_ count: Int) -> String {
        switch count {
        case 0..<1000:
            return "\(count)"
        case 1000..<10_000:
            let formatted = Double(count) / 1000
            let rounded = (formatted * 10).rounded() / 10 
            return "\(rounded)k"
        default:
            let formatted = Double(count) / 1000
            let rounded = Int(formatted)
            return "\(rounded)k"
        }
    }
}
