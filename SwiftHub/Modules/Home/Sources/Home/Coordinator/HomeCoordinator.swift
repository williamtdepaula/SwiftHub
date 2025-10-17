//
//  HomeCoordinator.swift
//  Home
//
//  Created by Willian de Paula on 17/10/25.
//

import Core
import UIKit

public class HomeCoordinator: BaseCoordinator {
    override public func start() {
        guard let homeFactory = InjecterContainer.shared.resolve(HomeFactory.self) else { return }
        
        let homeVC = homeFactory.makeHomeViewController()
        
        navigationController?.setViewControllers([homeVC], animated: true)
    }
}
