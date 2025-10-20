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
    
    private lazy var titleImageView: UIImageView = {
        let view = UIImageView()
        view.useConstraints()
        return view
    }()
    
    var data: RepositoryPresentation? {
        didSet {
            guard let data else { return }
            setupDataView(data)
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

// MARK: Private funcs
extension RepositoryTableViewCell {
    private func setupDataView(_ data: RepositoryPresentation) {
        title.text = data.title
        descriptionView.text = data.description
        setupImage(data)
    }
    
    private func setupImage(_ data: RepositoryPresentation) {
        let roundCorner = RoundCornerImageProcessor(radius: .widthFraction(0.2), roundingCorners: [.all])
        let pngSerializer = FormatIndicatedCacheSerializer.png
        imageView?.kf.setImage(
            with: data.owenerAvatarUrl,
            options: [.processor(roundCorner), .cacheSerializer(pngSerializer)]
        )
    }
}

// MARK: CodeView
extension RepositoryTableViewCell: CodeView {
    func setupViewHierarchy() {
        contentView.addSubview(titleImageView)
        contentView.addSubview(title)
        contentView.addSubview(descriptionView)
    }
    
    func setupConstraints() {
        let edgeMargin = 16.0
        
        NSLayoutConstraint.activate([
            titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edgeMargin),
            titleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: edgeMargin),
            titleImageView.widthAnchor.constraint(equalToConstant: 32),
            titleImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 4),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edgeMargin),
            title.topAnchor.constraint(equalTo: titleImageView.topAnchor)
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
