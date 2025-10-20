//
//  RepositoryPresentationMapperTests.swift
//  Home
//
//  Created by Willian de Paula on 20/10/25.
//

import Testing

import Core
import Foundation

@testable import Home

struct RepositoryPresentationMapperTests {
    @Test func mapContentSuccessfully() throws {
        let repository = Repository.mock01
        
        let repositoryPresentation = RepositoryPresentationMapper.map(entity: repository)
        
        #expect(repositoryPresentation.id == repository.id)
        #expect(repositoryPresentation.description == repository.description)
        #expect(repositoryPresentation.forksCount.isEmpty == false)
        #expect(repositoryPresentation.starsCount.isEmpty == false)
        #expect(repositoryPresentation.owenerUserName == repository.owner.userName)
        #expect(repositoryPresentation.owenerAvatarUrl != nil)
    }
    
    @Test("Validates the formatting of the count of stars and forks", arguments: [
        (stars: 850, forks: 123, expectedStars: "850", expectedForks: "123"),
        (stars: 2300, forks: 1800, expectedStars: "2.3k", expectedForks: "1.8k"),
        (stars: 12345, forks: 15670, expectedStars: "12k", expectedForks: "15k")
    ])
    func formmatCountsCorrectly(arguments: (stars: Int, forks: Int, expectedStars: String, expectedForks: String)) throws {
        let repository = Repository(
            id: 1,
            name: "TestRepo",
            starsCount: arguments.stars,
            forksCount: arguments.forks,
            description: "desc",
            owner: .init(id: 0, userName: "Someone", avatarStringUrl: "https://avatar.url")
        )
        
        let mapped = RepositoryPresentationMapper.map(entity: repository)
        
        #expect(mapped.starsCount == arguments.expectedStars)
        #expect(mapped.forksCount == arguments.expectedForks)
    }
}
