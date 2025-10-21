//
//  PullRequestDTOTests.swift
//  Infrastructure
//
//  Created by Willian de Paula on 20/10/25.
//

import Testing

import Core

@testable import Infrastructure

struct PullRequestDTOTests {
    @Test("Conversion to entity", arguments: [
        (dto: PullRequestDTO.mockOpen, expectedState: PullRequest.State.open),
        (dto: PullRequestDTO.mockClosed, expectedState: PullRequest.State.closed),
        (dto: PullRequestDTO.mockMerged, expectedState: PullRequest.State.merged),
    ])
    func convertToModel(dto: PullRequestDTO, expectedState: PullRequest.State) async throws {
        
        let model = dto.toModel()
        
        #expect(model.id == dto.id)
        #expect(model.title == dto.title)
        #expect(model.body == dto.body)
        #expect(model.createdAt == dto.created_at)
        #expect(model.stringUrl == dto.html_url)
        #expect(model.user.id == dto.user.id)
        #expect(model.user.userName == dto.user.login)
        #expect(model.user.avatarStringUrl == dto.user.avatar_url)
        #expect(model.state == expectedState)
    }
}
