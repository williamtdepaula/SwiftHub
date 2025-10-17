//
//  HomeCoordinator.swift
//  Home
//
//  Created by Willian de Paula on 17/10/25.
//

import Core
import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    var parent: (any Core.Coordinator)?
    
    var children: [any Core.Coordinator] = []
    
    func start() {
        
    }
}
