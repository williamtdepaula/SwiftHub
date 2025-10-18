//
//  HomeViewModel.swift
//  Home
//
//  Created by Willian de Paula on 17/10/25.
//

import Foundation
import Infrastructure
import RxSwift

@MainActor
final class HomeViewModel {
    let repositoryUseCase: ReposUseCasesProtocol
    
    let repositories = PublishSubject<[Repository]>()
    
    init(repositoryUseCase: ReposUseCasesProtocol) {
        self.repositoryUseCase = repositoryUseCase
        
        repositories.subscribe { repositories in
            print("Hey! we got", repositories)
        }
    }
    
    func loadRepos() async {
        do {
            let repositories = try await repositoryUseCase.getRepositories(page: 1)
            self.repositories.onNext(repositories)
        } catch {
            print("Error:", error)
        }
    }
}
