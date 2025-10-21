//
//  AppCoordinator.swift
//  SwiftHub
//
//  Created by Willian de Paula on 20/10/25.
//

import Core
import UIKit

public class AppCoordinator: BaseCoordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        let navigationController = UINavigationController()
        super.init(navigationController: navigationController)
    }
    
    override public func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        
        addChild(homeCoordinator)
        
        homeCoordinator.start()
        
    }
}
