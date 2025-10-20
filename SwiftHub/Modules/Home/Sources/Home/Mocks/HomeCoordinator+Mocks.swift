//
//  HomeCoordinator+Mocks.swift
//  Home
//
//  Created by Willian de Paula on 20/10/25.
//

import Core

#if DEBUG
final class FakeHomeCoordinator: HomeCoordinating {
    var onPressRepositoryCalled = false
    
    func onPressRepository(ownerName: String, repositoryName: String) {
        onPressRepositoryCalled = true
    }
}
#endif
