// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "balta-danger",
    dependencies: [
        .package(url: "https://github.com/danger/swift.git", from: "1.5.6"),
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.32.0")
    ],
    targets: [
        .target(name: "balta-danger", dependencies: ["Danger"], path: "balta", sources: ["test.swift"])
    ])
