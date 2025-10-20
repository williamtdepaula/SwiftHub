//
//  PullRequestPresentationMapper.swift
//  PullRequests
//
//  Created by Willian de Paula on 20/10/25.
//


import Testing

import Core
import Foundation

@testable import PullRequests

struct RepositoryPresentationMapperTests {
    @Test func mapContentSuccessfully() throws {
        let pullRequest = PullRequest.mock01
        
        let repositoryPresentation = PullRequestPresentationMapper.map(entity: pullRequest)
        
        #expect(repositoryPresentation.id == pullRequest.id)
        #expect(repositoryPresentation.body == pullRequest.body)
        #expect(repositoryPresentation.title == pullRequest.title)
        #expect(repositoryPresentation.createdAtFormatted == "26 de jan. de 2011")
        #expect(repositoryPresentation.createdBy == "Por \(pullRequest.user.userName)")
    }
    
    @Test("Validates each possible format value of createdAtFormmated", arguments: [
        ("2025-10-20T11:59:30Z", "Há 30 segundos"),
        ("2025-10-20T11:55:00Z", "Há 5 minutos"),
        ("2025-10-20T10:00:00Z", "Há 2 horas"),
        ("2025-10-17T12:00:00Z", "Há 3 dias"),
        ("2025-10-14T12:00:00Z", "14 de out. de 2025"),
        ("2025-10-", "")
    ])
    func createdAtFormatation(from dateString: String, expectation: String) {
        let formatter = ISO8601DateFormatter()
        
        let entity = PullRequest(id: 1, title: "Some PR", body: "Resolves something", createdAt: dateString, user: .mock01)

        let now = formatter.date(from: "2025-10-20T12:00:00Z")!
        let result = PullRequestPresentationMapper.map(entity: entity, now: now)
        #expect(result.createdAtFormatted == expectation)
    }
    
    @Test("Validates each possible value of createdBy", arguments: [
        ("The Dev", "Por The Dev"),
        ("", "")
    ])
    func createdByFormatation(userName: String, expectation: String) {        
        let entity = PullRequest(
            id: 1,
            title: "Some PR",
            body: "Resolves something",
            createdAt: "2025-10-20T11:59:30Z",
            user: .init(id: 1, userName: userName, avatarStringUrl: "")
        )

        let result = PullRequestPresentationMapper.map(entity: entity)
        #expect(result.createdBy == expectation)
    }
}
