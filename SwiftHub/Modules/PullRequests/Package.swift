// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PullRequests",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "PullRequests",
            targets: ["PullRequests"]
        ),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "Infrastructure", path: "../Infrastructure"),
        .package(name: "UI", path: "../UI"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "8.0.0"))
    ],
    targets: [
        .target(
            name: "PullRequests",
            dependencies: [
                "Core",
                "Infrastructure",
                "UI",
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxBlocking", package: "RxSwift"),
                .product(name: "Kingfisher", package: "Kingfisher")
            ]
        ),
        .testTarget(
            name: "PullRequestsTests",
            dependencies: ["PullRequests"]
        ),
    ]
)
