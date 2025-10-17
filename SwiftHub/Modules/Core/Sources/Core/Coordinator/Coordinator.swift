//
//  Coordinator.swift
//  Core
//
//  Created by Willian de Paula on 17/10/25.
//

import UIKit

@MainActor
public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    var parent: (any Coordinator)? { get set }
    var children: [any Coordinator] { get set }
    
    func start()
}

@MainActor
open class BaseCoordinator: Coordinator {
    
    public var navigationController: UINavigationController?
    public weak var parent: (any Coordinator)?
    public var children: [any Coordinator] = []

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    open func start() {
        
    }

    public func addChild(_ coordinator: any Coordinator) {
        children.append(coordinator)
    }

    public func removeChild(_ coordinator: any Coordinator) {
        children.removeAll { $0 === coordinator as AnyObject }
    }
}
