//
//  PullRequestTableViewCell.swift
//  PullRequests
//
//  Created by Willian de Paula on 20/10/25.
//

import UIKit
import Core
import RxSwift
import UI
import Kingfisher

final class PullRequestTableViewCell: UITableViewCell {
    
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
    
    private lazy var ownerImageView: UIImageView = {
        let view = UIImageView()
        view.useConstraints()
        return view
    }()
    
    private lazy var mergeStateIcon: UIImageView = {
        let view = UIImageView()
        view.useConstraints()
        return view
    }()
    
    private lazy var createdAtLabel: UILabel = {
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
    
    var data: PullRequestPresentation? {
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
extension PullRequestTableViewCell {
    private func setupDataView(_ data: PullRequestPresentation) {
        handleTitleLeadingAnchor()
        
        title.text = data.title
        descriptionView.text = data.body
        userNameLabel.text = data.createdBy
        createdAtLabel.text = data.createdAtFormatted
        setupOwnerImage(data)
        setupMergeStateIcon()
    }
    
    private func setupMergeStateIcon() {
        guard let data else { return }
        mergeStateIcon.isHidden = false
        
        switch data.state {
        case .open:
            mergeStateIcon.image = UIImage(named: "Merge")
            mergeStateIcon.tintColor = .systemGreen
        case .closed:
            mergeStateIcon.image = UIImage(named: "MergeBlocked")
            mergeStateIcon.tintColor = .systemRed
        case .merged:
            mergeStateIcon.image = UIImage(named: "Merge")
            mergeStateIcon.tintColor = .systemPurple
        case .none:
            mergeStateIcon.isHidden = true
        }
    }
    
    private func setupOwnerImage(_ data: PullRequestPresentation) {
        let roundCorner = RoundCornerImageProcessor(radius: .widthFraction(0.2), roundingCorners: [.all])
        let pngSerializer = FormatIndicatedCacheSerializer.png
        
        ownerImageView.kf.setImage(
            with: data.ownerAvatarURL,
            options: [.processor(roundCorner), .cacheSerializer(pngSerializer)]
        )
    }
    
    private func handleTitleLeadingAnchor() {
        self.titleLeadingConstraint?.isActive = false
        
        if let data, data.state != .none {
            self.titleLeadingConstraint = self.title.leadingAnchor.constraint(equalTo: self.mergeStateIcon.trailingAnchor, constant: 4)
        } else {
            self.titleLeadingConstraint = self.title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: MARGIN_EDGE)
        }
        self.titleLeadingConstraint?.isActive = true
    }
}

// MARK: CodeView
extension PullRequestTableViewCell: CodeView {
    func setupViewHierarchy() {
        contentView.addSubview(title)
        contentView.addSubview(descriptionView)
        contentView.addSubview(mergeStateIcon)
        
        contentView.addSubview(createdAtLabel)
        
        contentView.addSubview(ownerImageView)
        contentView.addSubview(userNameLabel)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            mergeStateIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MARGIN_EDGE),
            mergeStateIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MARGIN_EDGE),
            mergeStateIcon.widthAnchor.constraint(equalToConstant: 24),
            mergeStateIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        handleTitleLeadingAnchor()
        
        NSLayoutConstraint.activate([
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -MARGIN_EDGE),
            title.centerYAnchor.constraint(equalTo: mergeStateIcon.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MARGIN_EDGE),
            descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -MARGIN_EDGE),
            descriptionView.topAnchor.constraint(equalTo: mergeStateIcon.bottomAnchor, constant: 6),
            descriptionView.bottomAnchor.constraint(equalTo: createdAtLabel.topAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            createdAtLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MARGIN_EDGE),
            createdAtLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -MARGIN_EDGE)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -MARGIN_EDGE),
            userNameLabel.bottomAnchor.constraint(equalTo: createdAtLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            ownerImageView.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            ownerImageView.trailingAnchor.constraint(equalTo: userNameLabel.leadingAnchor, constant: -8),
            ownerImageView.widthAnchor.constraint(equalToConstant: 20),
            ownerImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func setupAddtionalConfigs() {
        selectionStyle = .none
        contentView.backgroundColor = Theme.Color.background
    }
    
}
