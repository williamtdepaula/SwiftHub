//
//  SceneDelegate.swift
//  SwiftHub
//
//  Created by Willian de Paula on 17/10/25.
//

import UIKit
import Swinject

import Home
import PullRequests

import Core
import Infrastructure
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var initialCoordinator: Coordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        registerDependencies()
        setupRootViewController(windowScene)
        setupAppearance()
    }

}

extension SceneDelegate {
    func registerDependencies() {
        
        let container = InjecterContainer.shared
        
        container.register(HomeFactory.self) { _ in
            HomeModuleFactory()
        }
        
        container.register(PullRequestsFactory.self) { _ in
            PullRequestsViewControllerFactory()
        }
        
        container.register(RepositoryUseCaseFactory.self) { _ in
            RepositoryUseCasesFactory()
        }
        
        container.register(PullRequestUseCaseFactory.self) { _ in
            PullRequestUseCasesFactoryImpl()
        }
        
    }
    
    func setupRootViewController(_ windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        
        initialCoordinator = AppCoordinator(window: window!)
        
        initialCoordinator.start()
        
    }
    
    func setupAppearance() {        
        Theme(navigationController: initialCoordinator.navigationController)
            .setAppearance()
    }
}
