//
//  ViewModelTests.swift
//  Home
//
//  Created by Willian de Paula on 18/10/25.
//

import Testing

@testable import Home

@MainActor
struct ViewModelTests {
    @Test func loadInitialDataSuccefully() async throws {
        let useCases = ReposUseCasesMock(theCase: .success)
        
        let viewModel = HomeViewModel(repositoryUseCase: useCases)
        
        await viewModel.loadRepositories()
        
        #expect(viewModel.screenState.value == .loadedSuccefully)
        #expect(viewModel.repositories.value.isEmpty == false)
    }
    
    @Test func loadInitialDataFailure() async throws {
        let useCases = ReposUseCasesMock(theCase: .error)
        
        let viewModel = HomeViewModel(repositoryUseCase: useCases)
        
        await viewModel.loadRepositories()
        
        #expect(viewModel.screenState.value == .error)
        #expect(viewModel.repositories.value.isEmpty == true)
    }
    
    @Test func onRenderMoreItemsWhenNotAchievedMinimumItem() async throws {
        let useCases = ReposUseCasesMock(theCase: .success)
        
        let viewModel = HomeViewModel(repositoryUseCase: useCases)
        
        await viewModel.loadRepositories()
        
        let totalItems = viewModel.repositories.value.count
        
        await viewModel.onRender(row: 0)
        
        #expect(viewModel.screenState.value == .loadedSuccefully)
        #expect(viewModel.repositories.value.count == totalItems)
    }
    
    @Test func onRenderMoreItemsWhenAchievedMinimumItem() async throws {
        let useCases = ReposUseCasesMock(theCase: .success)
        
        let viewModel = HomeViewModel(repositoryUseCase: useCases)
        
        await viewModel.loadRepositories()
        
        let totalItems = viewModel.repositories.value.count
        
        await viewModel.onRender(row: totalItems - 5)
        
        #expect(viewModel.screenState.value == .loadedSuccefully)
        #expect(viewModel.repositories.value.count > totalItems)
    }
}
