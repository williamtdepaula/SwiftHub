//
//  RepositoryCell.swift
//  Home
//
//  Created by Willian de Paula on 18/10/25.
//

import UIKit
import Core
import RxSwift
import UI

final class RepositoryTableViewCell: UITableViewCell {
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.useConstraints()
        view.textColor = Theme.Color.title
        view.font = .systemFont(ofSize: 16, weight: .black)
        return view
    }()
    
    var data: RepositoryPresentation? {
        didSet {
            guard let data else { return }
            
            title.text = data.title
        }
    }
    
    override func prepareForReuse() {
        data = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: CodeView
extension RepositoryTableViewCell: CodeView {
    func setupViewHierarchy() {
        contentView.addSubview(title)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupAddtionalConfigs() {
        contentView.backgroundColor = .clear
    }
    
}
