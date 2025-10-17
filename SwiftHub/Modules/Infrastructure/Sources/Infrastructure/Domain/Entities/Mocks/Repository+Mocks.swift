//
//  Repository+Mocks.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

extension Repository {
    static let mocks: [Self] = [
        mock01,
        mock02,
        mock03,
        mock04,
        mock05,
        mock06
    ]
    
    static var mock01: Self {
        let owner = Owner(id: 1, userName: "JohnDoe", avatarStringUrl: "")
        return Repository(id: 1, name: "Swift Repo", starsCount: 0, forksCount: 0, description: "Small description", owner: owner)
    }
    static var mock02: Self {
        let owner = Owner(id: 2, userName: "JoanaDoe", avatarStringUrl: "")
        return Repository(id: 1, name: "Some repository", starsCount: 0, forksCount: 0, description: "Small description", owner: owner)
    }
    static var mock03: Self {
        let owner = Owner(id: 3, userName: "Someone", avatarStringUrl: "")
        return Repository(id: 1, name: "List in swift", starsCount: 0, forksCount: 0, description: "Small description", owner: owner)
    }
    static var mock04: Self {
        let owner = Owner(id: 1, userName: "JohnDoe", avatarStringUrl: "")
        return Repository(id: 1, name: "SuperApp", starsCount: 0, forksCount: 0, description: "Small description", owner: owner)
    }
    static var mock05: Self {
        let owner = Owner(id: 2, userName: "JoanaDoe", avatarStringUrl: "")
        return Repository(id: 1, name: "An repository", starsCount: 0, forksCount: 0, description: "Small description", owner: owner)
    }
    static var mock06: Self {
        let owner = Owner(id: 5, userName: "Some_another_one", avatarStringUrl: "")
        return Repository(id: 1, name: "Swift studies", starsCount: 0, forksCount: 0, description: "Small description", owner: owner)
    }
}
