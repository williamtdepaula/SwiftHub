//
//  HomeViewModel.swift
//  Home
//
//  Created by Willian de Paula on 17/10/25.
//

import Foundation
import Infrastructure

@MainActor
final class HomeViewModel {
    let repositoryUseCase: ReposUseCasesProtocol
    
    init(repositoryUseCase: ReposUseCasesProtocol) {
        self.repositoryUseCase = repositoryUseCase
    }
    
    func loadRepos() async {
        do {
            let repositories = try await repositoryUseCase.getRepositories(page: 1)
        } catch {
            print("Error:", error)
        }
    }
}
