//
//  RepositoryTableView.swift
//  Home
//
//  Created by Willian de Paula on 18/10/25.
//

import UIKit
import Core
import RxSwift
import RxCocoa

final class RepositoryTableView: UIView {
    
    var repositories = PublishSubject<[RepositoryPresentation]>()
    var cellWillDisplay = PublishSubject<IndexPath>()
    
    var isLoadingMore: Bool = false {
        didSet {
            handleLoadingMore()
        }
    }
    
    private let disposeBag = DisposeBag()
    
    private lazy var loadingAnimationView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.pause()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.useConstraints()
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private funcs
extension RepositoryTableView {
    private func setupBinding() {
        repositories.bind(
            to: tableView.rx.items(
                cellIdentifier: RepositoryTableViewCell.description(),
                cellType: RepositoryTableViewCell.self
            )
        ) { (_, repository, cell) in
            cell.data = repository
        }
        .disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell.subscribe(
            onNext: { [weak cellWillDisplay] (cell, indexPath) in
                cellWillDisplay?.onNext(indexPath)
            }
        )
        .disposed(by: disposeBag)
    }
    
    private func handleLoadingMore() {
        switch isLoadingMore {
        case true:
            tableView.tableFooterView = loadingAnimationView
            loadingAnimationView.play()
        case false:
            tableView.tableFooterView = nil
            loadingAnimationView.pause()
        }
    }
}

// MARK: CodeView
extension RepositoryTableView: CodeView {
    func setupViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupAddtionalConfigs() {
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.description())
        setupBinding()
    }
    
    
}
