//
//  PullRequestsViewModel.swift
//  PullRequests
//
//  Created by Willian de Paula on 20/10/25.
//

import Foundation
import Core
import RxSwift
import RxRelay

@MainActor
final class PullRequestsViewModel {
    
    private weak var coordinator: PullRequestsCoordinating?
    
    private let pullRequestUseCases: PullRequestUseCasesProtocol
    
    private let ownerName: String
    
    private var currentPage: Int = 1
    
    private let pullRequestsData = BehaviorRelay<[PullRequest]>(value: [])
    
    let screenState = BehaviorRelay<ScreenState>(value: .idle)
    
    var pullRequests: Observable<[PullRequestPresentation]> {
        pullRequestsData
            .map({ $0.map({ PullRequestPresentationMapper.map(entity: $0) }) })
    }
    
    let repositoryName: String
    
    init(
        coordinator: PullRequestsCoordinating,
        ownerName: String,
        repositoryName: String,
        pullRequestUseCases: PullRequestUseCasesProtocol
    ) {
        self.ownerName = ownerName
        self.repositoryName = repositoryName
        self.coordinator = coordinator
        self.pullRequestUseCases = pullRequestUseCases
    }
}

// MARK: Public funcs
extension PullRequestsViewModel {
    func loadPullRequests(type: LoadType = .commonLoad) async {
        updateLoadingState(type, to: true)
        do {
            let result = try await pullRequestUseCases.getPullRequests(ownerName: ownerName, repositoryName: repositoryName, page: currentPage)
            let currentPullRequests = pullRequestsData.value
            pullRequestsData.accept(currentPullRequests + result)
            updateLoadingState(type, to: false)
            
            currentPage += 1
        } catch {
            if type == .commonLoad {
                screenState.accept(.error)
                pullRequestsData.accept([])
            } else {
                screenState.accept(.filled)
            }
        }
    }
    
    func onRender(row: Int) async {
        await loadMoreIfPossible(renderedRow: row)
    }
    
    func onTapCell(at indexPath: IndexPath) {
        guard indexPath.row < pullRequestsData.value.count else { return }
        
        let pullRequest = pullRequestsData.value[indexPath.row]
        
        coordinator?.onPressPullRequest(pullRequest)
    }
}

// MARK: Private funcs
extension PullRequestsViewModel {
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
            await loadPullRequests(type: .infiniteLoading)
        }
    }
    
    private func canLoadMoreItems(_ renderedRow: Int) -> Bool {
        let hasContent = !pullRequestsData.value.isEmpty
        let isNotLoadingMore = screenState.value == .filled
        let achievedMinimumRow = renderedRow == pullRequestsData.value.count - 5
        
        return hasContent && isNotLoadingMore && achievedMinimumRow
    }
}

// MARK: - Public funcs
extension PullRequestsViewModel {
    func onPressBack() {
        coordinator?.onPressToBack()
    }
}
