import UIKit
import Swinject

@MainActor
public protocol HomeFactory {
    func makeHomeViewController(coordinator: HomeCoordinating) -> UIViewController
}

@MainActor
public protocol PullRequestsFactory {
    func makeViewController(coordinator: PullRequestsCoordinating, pullRequestUseCases: PullRequestUseCasesProtocol, ownerName: String, repositoryName: String) -> UIViewController
}

@MainActor
public protocol RepositoryUseCaseFactory {
    func make() -> ReposUseCasesProtocol
}

@MainActor
public protocol PullRequestUseCaseFactory {
    func make() -> PullRequestUseCasesProtocol
}

@MainActor
public class InjecterContainer {
    public static let shared = Container()
}
