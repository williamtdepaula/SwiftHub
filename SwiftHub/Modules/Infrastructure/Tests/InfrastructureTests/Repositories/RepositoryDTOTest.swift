//
//  RepositoryDTOTest.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

import Testing

@testable import Infrastructure

struct RepositoryDTOTest {
    @Test func convertToModel() async throws {
        let dto = RepositoryDTO.mock

        let model = dto.toModel()

        #expect(model.id == dto.id)
        #expect(model.name == dto.name)
        #expect(model.starsCount == dto.stargazers_count)
        #expect(model.forksCount == dto.forks_count)
        #expect(model.description == dto.description)
        #expect(model.owner.id == dto.owner.id)
        #expect(model.owner.userName == dto.owner.login)
        #expect(model.owner.avatarStringUrl == dto.owner.avatar_url)
    }
}
