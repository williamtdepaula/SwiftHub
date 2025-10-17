//
//  RepositoryDTO+Mocks.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

extension RepositoryDTO {
    static let mock: Self = RepositoryDTO(
        id: 1,
        name: "MyRepo",
        stargazers_count: 42,
        forks_count: 10,
        description: "Some repository",
        owner: OwnerDTO(
            id: 99,
            login: "JohnDoe",
            avatar_url: "https://somelink.com/avatar.png"
        )
    )
}
