//
//  PullRequestFilter.swift
//  PullRequests
//
//  Created by Willian de Paula on 21/10/25.
//

enum PullRequestFilter: String, CaseIterable {
    case all = "Todos"
    case open = "Aberto"
    case closed = "Fechado"
    case merged = "Mesclado"
}
