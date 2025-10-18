//
//  ErrorView.swift
//  Core
//
//  Created by Willian de Paula on 18/10/25.
//

import UIKit

public class ErrorView: UIView {
    private lazy var label: UILabel = {
        let view = UILabel()
        view.text = "Ops! Ocorreu um erro inesperado"
        view.textAlignment = .center
        view.numberOfLines = 2
        view.textColor = .black
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.useConstraints()
        return view
    }()
    
    public lazy var button: UIButton = {
        let view = UIButton()
        view.setTitle("Tentar novamete", for: .normal)
        view.useConstraints()
        view.setTitleColor(.systemBlue, for: .normal)
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

// MARK: Code View
extension ErrorView: CodeView {
    public func setupViewHierarchy() {
        addSubview(label)
        addSubview(button)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8)
        ])
    }
    
    public func setupAddtionalConfigs() {
        
    }
    
    
}
