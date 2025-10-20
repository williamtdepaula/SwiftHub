//
//  Repository+Mocks.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

extension Repository {
    public static let mocks: [Self] = [
        mock01,
        mock02,
        mock03,
        mock04,
        mock05,
        mock06
    ]
    
    public static var mock01: Self {
        let owner = Owner(id: 1, userName: "JohnDoe", avatarStringUrl: "somelink.com.br/image.png")
        return Repository(id: 1, name: "Swift Repo", starsCount: 1000, forksCount: 1000, description: "Small description", owner: owner)
    }
    public static var mock02: Self {
        let owner = Owner(id: 2, userName: "JoanaDoe", avatarStringUrl: "")
        return Repository(id: 1, name: "Some repository", starsCount: 20000, forksCount: 20000, description: "Small description", owner: owner)
    }
    public static var mock03: Self {
        let owner = Owner(id: 3, userName: "Someone", avatarStringUrl: "")
        return Repository(id: 1, name: "List in swift", starsCount: 10, forksCount: 10, description: "Small description", owner: owner)
    }
    public static var mock04: Self {
        let owner = Owner(id: 1, userName: "JohnDoe", avatarStringUrl: "")
        return Repository(id: 4, name: "SuperApp", starsCount: 0, forksCount: 0, description: "Small description", owner: owner)
    }
    public static var mock05: Self {
        let owner = Owner(id: 2, userName: "JoanaDoe", avatarStringUrl: "")
        return Repository(id: 5, name: "An repository", starsCount: 0, forksCount: 0, description: "Small description", owner: owner)
    }
    public static var mock06: Self {
        let owner = Owner(id: 5, userName: "Some_another_one", avatarStringUrl: "")
        return Repository(id: 6, name: "Swift studies", starsCount: 0, forksCount: 0, description: "Small description", owner: owner)
    }
}
