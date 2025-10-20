//
//  PullRequestsViewController.swift
//  PullRequests
//
//  Created by Willian de Paula on 20/10/25.
//

import UIKit
import UI
import Core
import RxSwift

final class PullRequestsViewController: UIViewController {
    private let viewModel: PullRequestsViewModel
    
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: InfiniteTableView<PullRequestPresentation> = {
        
        let view = InfiniteTableView<PullRequestPresentation>(
            cellsToRegister: [PullRequestTableViewCell.self],
            cellConfigurator: { [weak self] cell, pullRequest in
                self?.setupCell(cell: cell, pullRequest: pullRequest)
            },
            cellIdentifier: { [weak self] pullRequest in
                PullRequestTableViewCell.description()
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
        setupBinding()
        
        Task { [weak self] in
            await self?.viewModel.loadPullRequests()
        }
    }
}

// MARK: Private funcs
extension PullRequestsViewController {
    private func handleScreenState(_ state: ScreenState) {
        // Sets default values
        errorView.isHidden = true
        tableView.isHidden = false
        tableView.isLoadingMore = false
        loadingAnimationView.pause()
        
        switch state {
        case .loading:
            tableView.isHidden = true
            loadingAnimationView.play()
        case .loadingMore:
            tableView.isLoadingMore = true
        case .error:
            errorView.isHidden = false
            tableView.isHidden = true
        default:
            break
        }
    }
    
    private func setupCell(cell: UITableViewCell, pullRequest: PullRequestPresentation) {
        guard let cell = cell as? PullRequestTableViewCell else { return }
        
        cell.data = pullRequest
    }
    
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

// MARK: Binding
extension PullRequestsViewController {
    
    private func setupBinding() {
        bindScreenState()
        bindPullRequests()
        bindCellWillDisplay()
        bindOnTapCell()
        bindButtonTryAgain()
    }
    
    fileprivate func bindScreenState() {
        viewModel.screenState
            .observe(on: MainScheduler.instance)
            .bind(
                onNext: { [weak self] screenState in
                    self?.handleScreenState(screenState)
                }
            )
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindPullRequests() {
        viewModel.pullRequests
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.data)
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindCellWillDisplay() {
        tableView.cellWillDisplay
            .bind(
                onNext: { [weak viewModel] indexPath in
                    Task {
                        await viewModel?.onRender(row: indexPath.row)
                    }
                }
            )
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindOnTapCell() {
        tableView.onTapCell
            .bind(
                onNext: { [weak viewModel] indexPath in
                    viewModel?.onTapCell(at: indexPath)
                }
            )
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindButtonTryAgain() {
        errorView.tryAgainTap
            .bind (
                onNext: { [weak viewModel] _ in
                    Task {
                        await viewModel?.loadPullRequests()
                    }
                }
            )
            .disposed(by: disposeBag)
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
