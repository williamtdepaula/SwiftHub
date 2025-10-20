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
    
    private weak var coordinator: HomeCoordinating?
    
    private var currentPage = 1
    
    private let repositoriesData = BehaviorRelay<[Repository]>(value: [])
    
    var repositories: Observable<[RepositoryPresentation]> {
        repositoriesData
                .map { $0.map(RepositoryPresentationMapper.map) }
    }
    
    let screenState = BehaviorRelay<ScreenState>(value: .idle)
    
    init(repositoryUseCase: ReposUseCasesProtocol, coordinator: HomeCoordinating) {
        self.repositoryUseCase = repositoryUseCase
        self.coordinator = coordinator
    }
}

// MARK: Public funcs
extension HomeViewModel {
    func loadRepositories(type: LoadType = .commonLoad) async {
        updateLoadingState(type, to: true)
        do {
            let result = try await repositoryUseCase.getRepositories(page: currentPage)
            let currentRepositories = repositoriesData.value
            repositoriesData.accept(currentRepositories + result)
            updateLoadingState(type, to: false)
            
            currentPage += 1
        } catch {
            if type == .commonLoad {
                screenState.accept(.error)
                repositoriesData.accept([])
            } else {
                screenState.accept(.filled)
            }
        }
    }
    
    func onRender(row: Int) async {
        await loadMoreIfPossible(renderedRow: row)
    }
    
    func onTapCell(at indexPath: IndexPath) {
        guard indexPath.row < repositoriesData.value.count else { return }

        let repository = repositoriesData.value[indexPath.row]
        
        coordinator?.onPressRepository(ownerName: repository.owner.userName, repositoryName: repository.name)
    }
}
    
// MARK: Private funcs
extension HomeViewModel {
    private func updateLoadingState(_ type: LoadType, to isLoading: Bool) {
        switch isLoading {
        case true:
            screenState.accept(type == .commonLoad ? .loading : .loadingMore)
        case false:
            screenState.accept(.filled)
        }
    }
    
    private func loadMoreIfPossible(renderedRow: Int) async {
        if canLoadMoreItems(renderedRow) {
            await loadRepositories(type: .infiniteLoading)
        }
    }
    
    private func canLoadMoreItems(_ renderedRow: Int) -> Bool {
        let hasContent = !repositoriesData.value.isEmpty
        let isNotLoadingMore = screenState.value == .filled
        let achievedMinimumRow = renderedRow == repositoriesData.value.count - 5
        
        return hasContent && isNotLoadingMore && achievedMinimumRow
    }
}
