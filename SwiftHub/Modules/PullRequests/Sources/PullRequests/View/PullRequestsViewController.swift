//
//  PullRequestsViewController.swift
//  PullRequests
//
//  Created by Willian de Paula on 20/10/25.
//

import UIKit
import UI
import RxSwift

final class PullRequestsViewController: UIViewController {
    private let viewModel: PullRequestsViewModel
    
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: InfiniteTableView<PullRequestPresentation> = {
        
        let view = InfiniteTableView<PullRequestPresentation>(
            cellsToRegister: [UITableViewCell.self],
            cellConfigurator: { [weak self] cell, repository in
//                self?.setupCell(cell: cell, repository: repository)
            },
            cellIdentifier: { [weak self] repository in
                return ""
//                RepositoryTableViewCell.description()
            })
        
        view.useConstraints()
        return view
    }()
    
    private lazy var loadingAnimationView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.useConstraints()
        view.pause()
        return view
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.useConstraints()
        view.isHidden = true
        return view
    }()
    
    init(viewModel: PullRequestsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

extension PullRequestsViewController {
    
    private func setBackButton() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
             style: .plain,
             target: self,
             action: #selector(handleTapBack)
        )

        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    private func handleTapBack() {
        viewModel.onPressBack()
    }
}

// MARK: CodeView
extension PullRequestsViewController: CodeView {
    func setupViewHierarchy() {
        view.addSubview(loadingAnimationView)
        view.addSubview(errorView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupAddtionalConfigs() {
        setBackButton()
        title = viewModel.repositoryName
        
        navigationItem.hidesBackButton = false
        
    }
}
