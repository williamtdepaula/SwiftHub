//
//  PullRequestPresentation.swift
//  PullRequests
//
//  Created by Willian de Paula on 20/10/25.
//

import Foundation

struct PullRequestPresentation {
    public let id: Int
    public let title: String
    public let body: String
    public let createdAtFormatted: String
    public let createdBy: String
    public let ownerAvatarURL: URL?
}
