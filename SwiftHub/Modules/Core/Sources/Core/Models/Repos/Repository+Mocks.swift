//
//  Repository+Mocks.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

#if DEBUG
extension Repository {
    public static let mocks: [Self] = [
        mock01,
        mock02,
        mock03
    ]
    
    public static let mock01: Self = Repository(id: 1, name: "Swift Repo", starsCount: 1000, forksCount: 1000, description: "Small description", owner: .mock01)
    public static let mock02: Self = Repository(id: 2, name: "Some repository", starsCount: 20000, forksCount: 20000, description: "Small description", owner: .mock02)
    public static let mock03: Self = Repository(id: 1, name: "List in swift", starsCount: 10, forksCount: 10, description: "Small description", owner: .mock03)
}
#endif
