//
//  PullRequestDTOTests.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Testing

@testable import Infrastructure

struct PullRequestDTOTests {
    @Test func convertToModel() async throws {
        let dto = PullRequestDTO.mock

        let model = dto.toModel()

        #expect(model.id == dto.id)
        #expect(model.title == dto.title)
        #expect(model.body == dto.body)
        #expect(model.createdAt == dto.created_at)
        #expect(model.owner.id == dto.owner.id)
        #expect(model.owner.userName == dto.owner.login)
        #expect(model.owner.avatarStringUrl == dto.owner.avatar_url)
    }
}
