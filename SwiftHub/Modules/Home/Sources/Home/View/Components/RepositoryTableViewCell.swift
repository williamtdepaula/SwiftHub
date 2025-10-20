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
    
    private let MARGIN_EDGE = 16.0
    
    private var titleLeadingConstraint: NSLayoutConstraint?
    
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
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.numberOfLines = 2
        return view
    }()
    
    private lazy var titleImageView: UIImageView = {
        let view = UIImageView()
        view.useConstraints()
        return view
    }()
    
    private lazy var starIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Star")
        view.tintColor = .systemGray
        view.useConstraints()
        return view
    }()
    
    private lazy var starsCountLabel: UILabel = {
        let view = UILabel()
        view.useConstraints()
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var forkIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Fork")
        view.tintColor = .systemGray
        view.useConstraints()
        return view
    }()
    
    private lazy var forksLabel: UILabel = {
        let view = UILabel()
        view.useConstraints()
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var userNameLabel: UILabel = {
        let view = UILabel()
        view.useConstraints()
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.numberOfLines = 1
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
        starsCountLabel.text = data.starsCount
        forksLabel.text = data.forksCount
        userNameLabel.text = data.owenerUserName
        setupImage(data)
    }
    
    private func setupImage(_ data: RepositoryPresentation) {
        let roundCorner = RoundCornerImageProcessor(radius: .widthFraction(0.2), roundingCorners: [.all])
        let pngSerializer = FormatIndicatedCacheSerializer.png
        
        titleImageView.kf.setImage(
            with: data.owenerAvatarUrl,
            options: [.processor(roundCorner), .cacheSerializer(pngSerializer)]
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                handleImageTitleLeadingAnchor(isImageLoaded: true)
            case .failure(_): // Case image fails to load, it sets the leading anchor to leading of cell
                handleImageTitleLeadingAnchor(isImageLoaded: false)
            }
            layoutIfNeeded()
        }
    }
    
    private func handleImageTitleLeadingAnchor(isImageLoaded: Bool) {
        self.titleLeadingConstraint?.isActive = false
        if isImageLoaded {
            self.titleLeadingConstraint = self.title.leadingAnchor.constraint(equalTo: self.titleImageView.trailingAnchor, constant: 4)
        } else {
            self.titleLeadingConstraint = self.title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: MARGIN_EDGE)
        }
        self.titleLeadingConstraint?.isActive = true
    }
}

// MARK: CodeView
extension RepositoryTableViewCell: CodeView {
    func setupViewHierarchy() {
        contentView.addSubview(titleImageView)
        contentView.addSubview(title)
        contentView.addSubview(descriptionView)
        
        contentView.addSubview(starIcon)
        contentView.addSubview(starsCountLabel)
        
        contentView.addSubview(forkIcon)
        contentView.addSubview(forksLabel)
        
        contentView.addSubview(userNameLabel)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MARGIN_EDGE),
            titleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MARGIN_EDGE),
            titleImageView.widthAnchor.constraint(equalToConstant: 24),
            titleImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        handleImageTitleLeadingAnchor(isImageLoaded: true)
        
        NSLayoutConstraint.activate([
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -MARGIN_EDGE),
            title.centerYAnchor.constraint(equalTo: titleImageView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MARGIN_EDGE),
            descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -MARGIN_EDGE),
            descriptionView.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 6),
            descriptionView.bottomAnchor.constraint(equalTo: starIcon.topAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            starIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MARGIN_EDGE),
            starIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -MARGIN_EDGE),
            starIcon.widthAnchor.constraint(equalToConstant: 16),
            starIcon.heightAnchor.constraint(equalToConstant: 16),
        ])
        
        NSLayoutConstraint.activate([
            starsCountLabel.leadingAnchor.constraint(equalTo: starIcon.trailingAnchor, constant: 4),
            starsCountLabel.bottomAnchor.constraint(equalTo: starIcon.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            forkIcon.leadingAnchor.constraint(equalTo: starsCountLabel.trailingAnchor, constant: 16),
            forkIcon.bottomAnchor.constraint(equalTo: starsCountLabel.bottomAnchor),
            forkIcon.widthAnchor.constraint(equalToConstant: 16),
            forkIcon.heightAnchor.constraint(equalToConstant: 16),
        ])
        
        NSLayoutConstraint.activate([
            forksLabel.leadingAnchor.constraint(equalTo: forkIcon.trailingAnchor, constant: 4),
            forksLabel.bottomAnchor.constraint(equalTo: forkIcon.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -MARGIN_EDGE),
            userNameLabel.bottomAnchor.constraint(equalTo: forksLabel.bottomAnchor)
        ])
    }
    
    func setupAddtionalConfigs() {
        contentView.backgroundColor = Theme.Color.background
    }
    
}
