//
//  HomeViewController.swift
//  Home
//
//  Created by Willian de Paula on 17/10/25.
//

import UI
import Core
import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: InfiniteTableView<RepositoryPresentation> = {
        
        let view = InfiniteTableView<RepositoryPresentation>(
            cellsToRegister: [RepositoryTableViewCell.self],
            cellConfigurator: { [weak self] cell, repository in
                self?.setupCell(cell: cell, repository: repository)
            },
            cellIdentifier: { _ in
                RepositoryTableViewCell.description()
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
    
    init(viewModel: HomeViewModel) {
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
            await self?.viewModel.loadRepositories()
        }
    }
}

// MARK: Private funcs
extension HomeViewController {
    private func setupCell(cell: UITableViewCell, repository: RepositoryPresentation) {
        guard let cell = cell as? RepositoryTableViewCell else { return }
        
        cell.data = repository
    }
    
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
}

// MARK: Binding
extension HomeViewController {
    
    private func setupBinding() {
        bindScreenState()
        bindRepositories()
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
    
    fileprivate func bindRepositories() {
        viewModel.repositories
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
                        await viewModel?.loadRepositories()
                    }
                }
            )
            .disposed(by: disposeBag)
    }
}

//MARK: CodeView
extension HomeViewController: CodeView {
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
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupAddtionalConfigs() {
        title = "MAIS POPULARES"
    }
    
    
}

