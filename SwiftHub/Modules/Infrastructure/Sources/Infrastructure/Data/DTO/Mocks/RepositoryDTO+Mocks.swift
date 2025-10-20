//
//  RepositoryDTO+Mocks.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

#if DEBUG
extension RepositoryDTO {
    static let mock: Self = RepositoryDTO(
        id: 1,
        name: "MyRepo",
        stargazers_count: 42,
        forks_count: 10,
        description: "Some repository",
        owner: .mock
    )
}
#endif
