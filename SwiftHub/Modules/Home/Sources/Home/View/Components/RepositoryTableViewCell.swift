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
import Kingfisher

final class RepositoryTableViewCell: UITableViewCell {
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.useConstraints()
        view.textColor = Theme.Color.title
        view.font = .systemFont(ofSize: 16, weight: .black)
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var descriptionView: UILabel = {
        let view = UILabel()
        view.useConstraints()
        view.textColor = Theme.Color.commonText
        view.font = .systemFont(ofSize: 16, weight: .black)
        view.numberOfLines = 2
        return view
    }()
    
    var data: RepositoryPresentation? {
        didSet {
            guard let data else { return }
            
            title.text = data.title
            descriptionView.text = data.description
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
        contentView.addSubview(descriptionView)
    }
    
    func setupConstraints() {
        let edgeMargin = 16.0
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeMargin),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeMargin),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: edgeMargin)
        ])
        
        NSLayoutConstraint.activate([
            descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeMargin),
            descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeMargin),
            descriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -edgeMargin),
            descriptionView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4)
        ])
    }
    
    func setupAddtionalConfigs() {
        contentView.backgroundColor = .clear
    }
    
}

// MARK: Constants
extension RepositoryTableViewCell {
    static let height: CGFloat = 200
}
