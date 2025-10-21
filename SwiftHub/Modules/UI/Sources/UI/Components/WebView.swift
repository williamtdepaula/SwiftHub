//
//  WebView.swift
//  UI
//
//  Created by Willian de Paula on 21/10/25.
//

import Core
import WebKit
import RxSwift

public class WebViewController: UIViewController {
    private let urlString: String
    
    private let disposeBag = DisposeBag()

    private lazy var webView: WKWebView = {
        let view = WKWebView(frame: .zero)
        view.useConstraints()
        view.navigationDelegate = self
        view.isHidden = true
        return view
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView(frame: .zero)
        view.useConstraints()
        view.isHidden = true
        return view
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.useConstraints()
        return view
    }()
    
    public init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        binding()
    }
}

// MARK: Private funcs
extension WebViewController {
    private func binding() {
        errorView.tryAgainTap
            .subscribe { [weak self] _ in
                self?.handleTryAgain()
            }
            .disposed(by: disposeBag)
    }
    
    private func loadUrl() {
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func handleSuccessLoad() {
        loading.pause()
        webView.isHidden = false
        errorView.isHidden = true
    }
    
    private func handleError() {
        loading.pause()
        webView.isHidden = true
        errorView.isHidden = false
    }
    
    private func handleTryAgain() {
        loading.play()
        errorView.isHidden = true
        loadUrl()
    }
}

// MARK:  WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        handleSuccessLoad()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        handleError()
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        handleError()
    }
}

// MARK: CodeView
extension WebViewController: CodeView {
    public func setupViewHierarchy() {
        view.addSubview(loading)
        view.addSubview(errorView)
        view.addSubview(webView)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    public func setupAddtionalConfigs() {
        loading.play()
        loadUrl()
    }
}
