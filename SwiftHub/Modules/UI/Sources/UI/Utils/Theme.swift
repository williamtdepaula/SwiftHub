//
//  Theme.swift
//  Core
//
//  Created by Willian de Paula on 18/10/25.
//

import UIKit

@MainActor
public class Theme {
    let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func setAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Theme.Color.highlight
        appearance.titleTextAttributes = [
            .foregroundColor: Theme.Color.commonText,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
        ]

        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.isTranslucent = true

        navigationController.view.backgroundColor = Theme.Color.background
    }
    
}

extension Theme {
    fileprivate final class BarButtonHandler: NSObject {
        private let action: () -> Void

        init(action: @escaping () -> Void) {
            self.action = action
        }

        @objc func handleTap() {
            action()
        }
    }
}
