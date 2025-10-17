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

extension Coordinator {
    /// Call this when the coordinator has completed its flow and should be removed from its parent.
    func childDidFinish(_ coordinator: any Coordinator) {
        for (index, child) in children.enumerated() {
            if child === coordinator {
                children.remove(at: index)
                break
            }
        }
    }
}
