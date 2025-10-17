import UIKit
import Swinject

@MainActor
public protocol HomeFactory {
    func makeHomeViewController() -> UIViewController
}

@MainActor
public class InjecterContainer {
    public static let shared = Container()
}
