//
//  HomeViewController.swift
//  Home
//
//  Created by Willian de Paula on 17/10/25.
//

import UIKit

public final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    
    private lazy var button: UIButton = {
        let view = UIButton(frame: .init(x: 500, y: 500, width: 100, height: 100))
        view.setTitle("Click me!", for: .normal)
        view.addTarget(self, action: #selector(viewModel.onPress), for: .touchUpInside)
        return view
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
