//
//  ViewModelTests.swift
//  Home
//
//  Created by Willian de Paula on 18/10/25.
//

import Testing

import Foundation
import RxSwift
import RxBlocking

@testable import Home

@MainActor
struct ViewModelTests {
    @Test func loadInitialDataSuccefully() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = ReposUseCasesMock(theCase: .success)
        
        let viewModel = HomeViewModel(repositoryUseCase: useCases, coordinator: coordinator)
        
        await viewModel.loadRepositories()
        
        #expect(viewModel.screenState.value == .filled)
        #expect(try viewModel.repositories.toBlocking().first()?.isEmpty == false)
    }
    
    @Test func loadInitialDataFailure() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = ReposUseCasesMock(theCase: .error)
        
        let viewModel = HomeViewModel(repositoryUseCase: useCases, coordinator: coordinator)
        
        await viewModel.loadRepositories()
        
        #expect(viewModel.screenState.value == .error)
        #expect(try viewModel.repositories.toBlocking().first()?.isEmpty == true)
    }
    
    @Test func onRenderMoreItemsWhenNotAchievedMinimumItem() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = ReposUseCasesMock(theCase: .success)
        
        let viewModel = HomeViewModel(repositoryUseCase: useCases, coordinator: coordinator)
        
        await viewModel.loadRepositories()
        
        let totalItemsBeforeTryLoadMore = try viewModel.repositories.toBlocking().first()?.count
        
        await viewModel.onRender(row: 0)
        
        #expect(viewModel.screenState.value == .filled)
        #expect(try viewModel.repositories.toBlocking().first()?.count == totalItemsBeforeTryLoadMore)
    }
    
    @Test func onRenderMoreItemsWhenAchievedMinimumItem() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = ReposUseCasesMock(theCase: .success)
        
        let viewModel = HomeViewModel(repositoryUseCase: useCases, coordinator: coordinator)
        
        await viewModel.loadRepositories()
        
        let totalItemsBeforeTryLoadMore = try viewModel.repositories.toBlocking().first()!.count
        
        await viewModel.onRender(row: totalItemsBeforeTryLoadMore - 5)
        
        #expect(viewModel.screenState.value == .filled)
        #expect(try viewModel.repositories.toBlocking().first()!.count > totalItemsBeforeTryLoadMore)
    }
    
    @Test func onRenderMoreItemsWhenAchievedMinimumItemWithError() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = ReposUseCasesMock(theCase: .errorOn(page: 2))
        
        let viewModel = HomeViewModel(repositoryUseCase: useCases, coordinator: coordinator)
        
        await viewModel.loadRepositories()
        
        let totalItemsBeforeTryLoadMore = try viewModel.repositories.toBlocking().first()!.count
        
        await viewModel.onRender(row: totalItemsBeforeTryLoadMore - 5)
        
        #expect(viewModel.screenState.value == .filled)
        #expect(try viewModel.repositories.toBlocking().first()!.count == totalItemsBeforeTryLoadMore)
    }
    
    @Test func onPressSomeItemThatDoesNotExist() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = ReposUseCasesMock(theCase: .success)
        
        let viewModel = HomeViewModel(repositoryUseCase: useCases, coordinator: coordinator)
        
        viewModel.onTapCell(at: IndexPath(row: 0, section: 0))
        
        #expect(viewModel.screenState.value == .idle)
        #expect(coordinator.onPressRepositoryCalled == false)
    }
    
    @Test func onPressSomeItemThatExist() async throws {
        let coordinator = FakeHomeCoordinator()
        let useCases = ReposUseCasesMock(theCase: .success)
        
        let viewModel = HomeViewModel(repositoryUseCase: useCases, coordinator: coordinator)
        
        await viewModel.loadRepositories()
        
        viewModel.onTapCell(at: IndexPath(row: 0, section: 0))
        
        #expect(viewModel.screenState.value == .filled)
        #expect(coordinator.onPressRepositoryCalled == true)
    }
}
