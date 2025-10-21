//
//  RepositoryTableView.swift
//  Home
//
//  Created by Willian de Paula on 18/10/25.
//

import UIKit
import RxSwift
import RxCocoa

/// Generic UITableView with **infinite scrolling** and reactive binding via RxSwift.
///
/// - Generic `T`: type of items to display.
/// - `data`: emits the elements to populate the table.
/// - `cellWillDisplay`: notifies which cell is about to appear (useful to load more items).
/// - `isLoadingMore`: controls the loading footer.
///
/// Initialization:
/// ```swift
/// InfiniteTableView<MyModel>(
///     cellsToRegister: [MyCell.self],
///     cellConfigurator: { cell, model in ... },
///     cellIdentifier: { _ in MyCell.description() }
/// )
/// ```
///
/// Behavior:
/// - Table updates automatically when `data` emits new values.
/// - Shows a loading footer when `isLoadingMore = true`.
/// - Supports multiple cell types.
public final class InfiniteTableView<T>: UIView {
    
    public var data = PublishSubject<[T]>()
    
    public var cellWillDisplay = PublishSubject<IndexPath>()
    
    public var onTapCell = PublishSubject<IndexPath>()
    
    public var isLoadingMore: Bool = false {
        didSet {
            handleLoadingMore()
        }
    }
    
    private let cellConfigurator: ((UITableViewCell, T) -> Void)
    
    private let cellIdentifier: ((T) -> String)
    
    private let cellsType: [UITableViewCell.Type]
    
    private let disposeBag = DisposeBag()
    
    private lazy var loadingAnimationView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.pause()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.useConstraints()
        return view
    }()
    
    public init(cellsToRegister: [UITableViewCell.Type], cellConfigurator: @escaping ((UITableViewCell, T) -> Void), cellIdentifier: @escaping ((T) -> String)) {
        self.cellsType = cellsToRegister
        self.cellConfigurator = cellConfigurator
        self.cellIdentifier = cellIdentifier
        super.init(frame: .zero)
        setupView()
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public funcs
extension InfiniteTableView {
    public func setHeaderView(_ view: UIView) {
        tableView.tableHeaderView = view
    }
}

// MARK: Private funcs
extension InfiniteTableView {
    private func registerCells() {
        cellsType.forEach({ tableView.register($0.self, forCellReuseIdentifier: $0.description()) })
    }
    
    private func setupBinding() {
        data.bind(to: tableView.rx.items) { [weak self] tableView, index, element in
            
            guard let self else { return UITableViewCell() }
            
            let identifier = cellIdentifier(element)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
            
            cellConfigurator(cell, element)
            
            return cell
        }
        .disposed(by: disposeBag)
        
        
        tableView.rx.willDisplayCell.subscribe(
            onNext: { [weak cellWillDisplay] (cell, indexPath) in
                cellWillDisplay?.onNext(indexPath)
            }
        )
        .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(
            onNext: { [weak onTapCell] indexPath in
                onTapCell?.onNext(indexPath)
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
extension InfiniteTableView: CodeView {
    public func setupViewHierarchy() {
        addSubview(tableView)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    public func setupAddtionalConfigs() {
        setupBinding()
        
        tableView.backgroundColor = .clear
    }
}
