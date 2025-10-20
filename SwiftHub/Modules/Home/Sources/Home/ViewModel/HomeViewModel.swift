//
//  HomeViewModel.swift
//  Home
//
//  Created by Willian de Paula on 17/10/25.
//

import Foundation
import Core
import RxSwift
import RxRelay

@MainActor
final class HomeViewModel {
    private let repositoryUseCase: ReposUseCasesProtocol
    
    private var currentPage = 1
    
    let repositories = BehaviorRelay<[RepositoryPresentation]>(value: [])
    let screenState = BehaviorRelay<ScreenState>(value: .loadedSuccefully)
    
    init(repositoryUseCase: ReposUseCasesProtocol) {
        self.repositoryUseCase = repositoryUseCase
    }
    
    func loadRepositories(type: LoadType = .commonLoad) async {
        updateLoadingState(type, to: true)
        do {
            let result = try await repositoryUseCase.getRepositories(page: currentPage)
            let currentRepositories = repositories.value
            let mappedResult = result.map({ RepositoryPresentationMapper.map(entity: $0) })
            repositories.accept(currentRepositories + mappedResult)
            updateLoadingState(type, to: false)
            
            currentPage += 1
        } catch {
            guard type == .commonLoad else { return }
            
            screenState.accept(.error)
            repositories.accept([])
        }
    }
    
    func onRender(row: Int) async {
        await loadMoreIfPossible(renderedRow: row)
    }
}

// MARK: Private funcs
extension HomeViewModel {
    private func updateLoadingState(_ type: LoadType, to isLoading: Bool) {
        switch isLoading {
        case true:
            screenState.accept(type == .commonLoad ? .loading : .loadingMore)
        case false:
            screenState.accept(.loadedSuccefully)
        }
    }
    
    private func loadMoreIfPossible(renderedRow: Int) async {
        if canLoadMoreItems(renderedRow) {
            await loadRepositories(type: .infiniteLoading)
        }
    }
    
    private func canLoadMoreItems(_ renderedRow: Int) -> Bool {
        let hasContent = !repositories.value.isEmpty
        let isNotLoadingMore = screenState.value == .loadedSuccefully
        let achievedMinimumRow = renderedRow == repositories.value.count - 5
        
        return hasContent && isNotLoadingMore && achievedMinimumRow
    }
}
