//
//  ViewModelTests.swift
//  PullRequests
//
//  Created by Willian de Paula on 18/10/25.
//

import Testing

import Foundation
import RxSwift
import RxBlocking

@testable import PullRequests

@MainActor
struct ViewModelTests {
    @Test func loadInitialDataSuccefully() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = FakePullRequestUseCases(theCase: .success)
        
        let viewModel = PullRequestsViewModel(
            coordinator: coordinator,
            ownerName: "Someone",
            repositoryName: "Repository Name",
            pullRequestUseCases: useCases
        )
        
        await viewModel.loadPullRequests()
        
        #expect(viewModel.screenState.value == .filled)
        #expect(try viewModel.pullRequests.toBlocking().first()?.isEmpty == false)
    }
    
    @Test func loadInitialDataFailure() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = FakePullRequestUseCases(theCase: .error)
        
        let viewModel = PullRequestsViewModel(
            coordinator: coordinator,
            ownerName: "Someone",
            repositoryName: "Repository Name",
            pullRequestUseCases: useCases
        )
        
        await viewModel.loadPullRequests()
        
        #expect(viewModel.screenState.value == .error)
        #expect(try viewModel.pullRequests.toBlocking().first()?.isEmpty == true)
    }
    
    @Test func onRenderMoreItemsWhenNotAchievedMinimumItem() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = FakePullRequestUseCases(theCase: .success)
        
        let viewModel = PullRequestsViewModel(
            coordinator: coordinator,
            ownerName: "Someone",
            repositoryName: "Repository Name",
            pullRequestUseCases: useCases
        )
        
        await viewModel.loadPullRequests()
        
        let totalItemsBeforeTryLoadMore = try viewModel.pullRequests.toBlocking().first()?.count
        
        await viewModel.onRender(row: 0)
        
        #expect(viewModel.screenState.value == .filled)
        #expect(try viewModel.pullRequests.toBlocking().first()?.count == totalItemsBeforeTryLoadMore)
    }
    
    @Test func onRenderMoreItemsWhenAchievedMinimumItem() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = FakePullRequestUseCases(theCase: .success)
        
        let viewModel = PullRequestsViewModel(
            coordinator: coordinator,
            ownerName: "Someone",
            repositoryName: "Repository Name",
            pullRequestUseCases: useCases
        )
        
        await viewModel.loadPullRequests()
        
        let totalItemsBeforeTryLoadMore = try viewModel.pullRequests.toBlocking().first()!.count
        
        await viewModel.onRender(row: totalItemsBeforeTryLoadMore - 5)
        
        #expect(viewModel.screenState.value == .filled)
        #expect(try viewModel.pullRequests.toBlocking().first()!.count > totalItemsBeforeTryLoadMore)
    }
    
    @Test func onRenderMoreItemsWhenAchievedMinimumItemWithError() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = FakePullRequestUseCases(theCase: .errorOn(page: 2))
        
        let viewModel = PullRequestsViewModel(
            coordinator: coordinator,
            ownerName: "Someone",
            repositoryName: "Repository Name",
            pullRequestUseCases: useCases
        )
        
        await viewModel.loadPullRequests()
        
        let totalItemsBeforeTryLoadMore = try viewModel.pullRequests.toBlocking().first()!.count
        
        await viewModel.onRender(row: totalItemsBeforeTryLoadMore - 5)
        
        #expect(viewModel.screenState.value == .filled)
        #expect(try viewModel.pullRequests.toBlocking().first()!.count == totalItemsBeforeTryLoadMore)
    }
    
    @Test func onPressSomeItemThatDoesNotExist() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = FakePullRequestUseCases(theCase: .success)
        
        let viewModel = PullRequestsViewModel(
            coordinator: coordinator,
            ownerName: "Someone",
            repositoryName: "Repository Name",
            pullRequestUseCases: useCases
        )
        
        viewModel.onTapCell(at: IndexPath(row: 0, section: 0))
        
        #expect(viewModel.screenState.value == .idle)
        #expect(coordinator.onPressPullRequestCalled == false)
    }
    
    @Test func onPressSomeItemThatExist() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = FakePullRequestUseCases(theCase: .success)
        
        let viewModel = PullRequestsViewModel(
            coordinator: coordinator,
            ownerName: "Someone",
            repositoryName: "Repository Name",
            pullRequestUseCases: useCases
        )
        
        await viewModel.loadPullRequests()
        
        viewModel.onTapCell(at: IndexPath(row: 0, section: 0))
        
        #expect(viewModel.screenState.value == .filled)
        #expect(coordinator.onPressPullRequestCalled == true)
    }
    
    @Test func onPressBack() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = FakePullRequestUseCases(theCase: .success)
        
        let viewModel = PullRequestsViewModel(
            coordinator: coordinator,
            ownerName: "Someone",
            repositoryName: "Repository Name",
            pullRequestUseCases: useCases
        )
        
        viewModel.onPressBack()
        
        #expect(coordinator.onPressToBackCalled == true)
    }
}
