//
//  PullRequestPresentationMapper.swift
//  PullRequests
//
//  Created by Willian de Paula on 20/10/25.
//

import Foundation
import Core

final class PullRequestPresentationMapper {
    static func map(entity: PullRequest, now: Date = Date()) -> PullRequestPresentation {
        return PullRequestPresentation(
            id: entity.id,
            title: entity.title,
            body: entity.body,
            createdAtFormatted: formatRelativeDate(from: entity.createdAt, now: now),
            createdBy: createdBy(entity.user.userName),
            ownerAvatarURL: URL(string: entity.user.avatarStringUrl)
        )
    }
    
    private static func createdBy(_ name: String) -> String {
        if name.isEmpty {
            return ""
        }
        
        return "Por \(name)"
    }
    
    private static func formatRelativeDate(from date: String, now: Date) -> String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: date) else {
            return ""
        }

        let seconds = Int(now.timeIntervalSince(date))

        if seconds < 60 {
            return "Há \(seconds) segundos"
        } else if seconds < 3600 { // One hour in seconds
            let minutes = seconds / 60
            return "Há \(minutes) minuto" + (minutes > 1 ? "s" : "")
        } else if seconds < 86400 { // 24 hours in seconds
            let hours = seconds / 3600
            return "Há \(hours) hora" + (hours > 1 ? "s" : "")
        } else if seconds < 432000 { // Five days in seconds
            let days = seconds / 86400
            return "Há \(days) dia" + (days > 1 ? "s" : "")
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "pt_BR")
            dateFormatter.dateFormat = "d 'de' MMM 'de' yyyy"
            return dateFormatter.string(from: date)
        }
    }
}
